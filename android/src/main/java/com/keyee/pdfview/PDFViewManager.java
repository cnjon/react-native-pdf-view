package com.keyee.pdfview;


import android.content.Context;
import android.util.Log;
import android.graphics.PointF;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

public class PDFViewManager extends SimpleViewManager<PdfView> {
    private static final String REACT_CLASS = "RCTPDFViewAndroid";
    private Context context;
    private PdfView pdfView;

    public PDFViewManager(ReactApplicationContext reactContext){
        this.context = reactContext;
    }

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    public PdfView createViewInstance(ThemedReactContext context) {
        this.pdfView = new PdfView(context, null);

        return this.pdfView;
    }

    @Override
    public void onDropViewInstance(PdfView pdfView) {
        pdfView = null;
    }

    @Override
    public void onAfterUpdateTransaction(PdfView pdfView) {
        super.onAfterUpdateTransaction(pdfView);
        pdfView.display(false);
    }

    @ReactProp(name = "pageNumber")
    public void setPageNumber(PdfView view, Integer pageNum) {
        if (pageNum >= 0){
            view.setPageNumber(pageNum);
        } else {
            view.setPageNumber(0);
        }
    }

    @ReactProp(name = "path")
    public void setPath(PdfView view, String pth) {
        view.setPath(pth);
    }

    @ReactProp(name = "src")
    public void setSrc(PdfView view, String src) {
        view.setSrc(src);
    }

    @ReactProp(name = "zoom")
    public void zoomTo(PdfView view, float zoomScale) {
        PointF pivot = new PointF(zoomScale, zoomScale);
        view.zoomCenteredTo(zoomScale, pivot);
    }

    private void showLog(final String str) {
        Log.w(REACT_CLASS, str);
    }
}
