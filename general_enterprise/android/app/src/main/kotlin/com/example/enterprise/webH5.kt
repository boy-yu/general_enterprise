package com.example.enterprise

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.KeyEvent
import android.view.View
import android.webkit.WebResourceRequest
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.TextView
import android.graphics.Bitmap
import android.app.ProgressDialog

class WebH5 : Activity() {
    var _webView :WebView ?= null
    var progressDialog: ProgressDialog? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.webh5)
        _webView = findViewById(R.id.webH5)
        var _intent: Intent = getIntent()
        Log.d("tar", _intent.toString())
        var text: TextView = findViewById(R.id.h5text)
        text.text = _intent.getStringExtra("title")
        _webView?.loadUrl(_intent.getStringExtra("url"))
        var webSettings = _webView?.settings
//        _webView?.webViewClient = object : WebViewClient() {
//            override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
//                return super.shouldOverrideUrlLoading(view, request)
//            }
//        }
        _webView?.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
                return super.shouldOverrideUrlLoading(view, request)
            }
            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                super.onPageStarted(view, url, favicon)
                showProgress("文件加载中")//开始加载动画
            }
            override fun onPageFinished(view: WebView?, url: String?) {
                super.onPageFinished(view, url)
                removeProgress()//当加载结束时移除动画
            }
        }
        webSettings?.useWideViewPort = true
        webSettings?.layoutAlgorithm = WebSettings.LayoutAlgorithm.NORMAL
        webSettings?.setSupportZoom(true)
        webSettings?.loadWithOverviewMode = true
        webSettings?.javaScriptEnabled = true
        webSettings?.builtInZoomControls = true
        webSettings?.displayZoomControls = false

        var _backView: View = findViewById(R.id.back)
        _backView.setOnClickListener(View.OnClickListener {
                if(_webView?.canGoBack()!!){
                    _webView?.goBack();

                }else{
                    finish();
                }
        })
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        if (keyCode == KeyEvent.KEYCODE_BACK && _webView?.canGoBack()!!) {
            _webView?.goBack();//返回上个页面
            return true;
        }

        return super.onKeyDown(keyCode, event)
    }

    //-----显示ProgressDialog
    fun showProgress(message: String?) {
        if (progressDialog == null) {
            progressDialog = ProgressDialog(this@WebH5, ProgressDialog.STYLE_SPINNER)
            progressDialog!!.setCancelable(true) //设置点击不消失
        }
        if (progressDialog!!.isShowing) {
            progressDialog!!.setMessage(message)
        } else {
            progressDialog!!.setMessage(message)
            progressDialog!!.show()
        }
    }

    //------取消ProgressDialog
    fun removeProgress() {
        if (progressDialog == null) {
            return
        }
        if (progressDialog!!.isShowing) {
            progressDialog!!.dismiss()
        }
    }
}