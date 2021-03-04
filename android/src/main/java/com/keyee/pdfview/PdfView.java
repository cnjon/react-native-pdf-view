package com.keyee.pdfview;

import android.content.Context;
import android.graphics.PointF;
import android.util.AttributeSet;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.github.barteksc.pdfviewer.PDFView;
import com.github.barteksc.pdfviewer.listener.OnLoadCompleteListener;
import com.github.barteksc.pdfviewer.listener.OnPageChangeListener;

import java.io.File;

import static java.lang.String.format;

public class PdfView extends PDFView implements OnPageChangeListener, OnLoadCompleteListener  {
    private static final String REACT_CLASS = "PDFViewWrapperAndroid";

    private Context context;
    Integer pageNumber = 0;
    String assetName;
    String filePath;

    public PdfView(Context context, AttributeSet set) {
        super(context, set);
        this.context = context;
    }

    @Override
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        if (this.isRecycled()) {
            this.display(false);
        }
    }

    @Override
    public void onPageChanged(int page, int pageCount) {
        pageNumber = page;
        showLog(format("%s %s / %s", filePath, page, pageCount));

        WritableMap event = Arguments.createMap();
        event.putString("message", "pageChanged|"+page+"|"+pageCount);
        ReactContext reactContext = (ReactContext)this.getContext();
        reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
                this.getId(),
                "topChange",
                event
        );
    }

    @Override
    public void loadComplete(int nbPages) {
        float width = this.getWidth();
        float height = this.getHeight();

        WritableMap event = Arguments.createMap();

        //Create
        event.putString("message", "loadComplete|"+nbPages+"|"+width+"|"+height);
        ReactContext reactContext = (ReactContext)this.getContext();
        reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
                this.getId(),
                "topChange",
                event
        );
    }

    public void display(boolean jumpToFirstPage) {
        if (jumpToFirstPage)
            pageNumber = 1;
        showLog(format("display %s %s", filePath, pageNumber));
        if (assetName != null) {
            this.fromAsset(assetName)
                    .defaultPage(pageNumber)
                    //.swipeVertical(true)
                    .onPageChange(this)
                    .onLoad(this)
                    .load();
        } else if (filePath != null){
            //fromFile,fromAsset
            //pdfView.fromAsset(fileName)
            File pdfFile = new File(filePath);
            this.fromFile(pdfFile)
                    .defaultPage(pageNumber)
                    //.showMinimap(false)
                    //.enableSwipe(true)
                    //.swipeVertical(true)
                    .onPageChange(this)
                    .onLoad(this)
                    .load();
        }
    }

    public void setAsset(String ast) {
        assetName = ast;
        display(false);
    }

    public void setPageNumber(Integer pageNum) {
        //view.setPageNumber(pageNum);
        if (pageNum >= 0){
            pageNumber = pageNum;
            display(false);
        }
    }

    public void setPath(String pth) {
        filePath = pth;
        display(false);
    }

    public void setSrc(String src) {
        //view.setSource(src);
        filePath = src;
        display(false);
    }

    public void zoomToScale(float zoomScale) {
        PointF pivot = new PointF(zoomScale, zoomScale);
        this.zoomCenteredTo(zoomScale, pivot);
    }

    private void showLog(final String str) {
        Log.w(REACT_CLASS, str);
    }
}
