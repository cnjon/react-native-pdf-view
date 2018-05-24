package com.keyee.pdfview;

import android.content.Context;
import android.graphics.PointF;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;

import com.github.barteksc.pdfviewer.PDFView;
import com.github.barteksc.pdfviewer.listener.OnLoadCompleteListener;
import com.github.barteksc.pdfviewer.listener.OnPageChangeListener;

import java.io.File;

import static java.lang.String.format;

public class PDFViewManager extends SimpleViewManager<PDFView> implements OnPageChangeListener, OnLoadCompleteListener {
    private static final String REACT_CLASS = "RCTPDFViewAndroid";
    private Context context;
    private PDFView view;

    Integer pageNumber = 0;
    String assetName;
    String filePath;

    public PDFViewManager(ReactApplicationContext reactContext) {
        this.context = reactContext;
    }

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    public PDFView createViewInstance(ThemedReactContext context) {
        return new PDFView(context, null);
    }

    @Override
    public void onPageChanged(int page, int pageCount) {
        pageNumber = page;
        showLog(format("%s %s / %s", filePath, page, pageCount));
    }

    private void display(PDFView pdfView, boolean jumpToFirstPage) {
        this.view = pdfView;

        if (jumpToFirstPage) {
            pageNumber = 0;
        }

        showLog(format("display %s %s", filePath, pageNumber));
        if (assetName != null) {
            pdfView.fromAsset(assetName)
                    .defaultPage(pageNumber)
                    .enableSwipe(true)
                    .swipeHorizontal(false)
                    .onPageChange(this)
                    .onLoad(this)
                    .load();
        } else if (filePath != null) {
            File pdfFile = new File(filePath);
            pdfView.fromFile(pdfFile)
                    .defaultPage(pageNumber)
                    .enableSwipe(true)
                    .swipeHorizontal(false)
                    .onPageChange(this)
                    .onLoad(this)
                    .load();
        }
    }

    @Override
    public void loadComplete(int nbPages) {
        WritableMap event = Arguments.createMap();
        event.putString("message", "" + nbPages);
        ReactContext reactContext = (ReactContext) view.getContext();
        reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
                view.getId(),
                "topChange",
                event
        );
    }

    @ReactProp(name = "asset")
    public void setAsset(PDFView view, String ast) {
        assetName = ast;
        display(view, false);
    }

    @ReactProp(name = "pageNumber")
    public void setPageNumber(PDFView view, Integer pageNum) {
        if (pageNum > 0) {
            pageNumber = pageNum;
            display(view, false);
        }
    }

    @ReactProp(name = "path")
    public void setPath(PDFView view, String pth) {
        filePath = pth;
        display(view, false);
    }

    @ReactProp(name = "src")
    public void setSrc(PDFView view, String src) {
        filePath = src;
        display(view, false);
    }

    @ReactProp(name = "zoom")
    public void zoomTo(PDFView view, float zoomScale) {
        PointF pivot = new PointF(zoomScale, zoomScale);
        view.zoomCenteredTo(zoomScale, pivot);
    }

    private void showLog(final String str) {
        Log.w(REACT_CLASS, str);
    }
}