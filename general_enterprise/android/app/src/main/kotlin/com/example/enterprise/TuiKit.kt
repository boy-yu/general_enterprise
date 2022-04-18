package com.example.enterprise

import android.content.Context
import android.util.Log
import com.example.asdf.GenerateTestUserSig
import com.tencent.imsdk.v2.*
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec


class TuiKit {
    private var skdId: Int = 1400446809
    private var signs: String = ""
    private var haha = object : V2TIMSimpleMsgListener() {
             override fun onRecvC2CTextMessage(msgID: String?, sender: V2TIMUserInfo?, text: String?) {
                super.onRecvC2CTextMessage(msgID, sender, text)
                Log.d("tag", text)
                basicMessageChannel?.send(mutableMapOf("userID" to (sender?.userID), "message" to (text)))
            }
    }
    lateinit var basicMessageChannel: BasicMessageChannel<Any>
    public fun init(context: Context, flutterEngine: FlutterEngine) {
        val config = V2TIMSDKConfig()
        config.setLogLevel(V2TIMSDKConfig.V2TIM_LOG_NONE);
        V2TIMManager.getInstance().initSDK(context, skdId, config, object : V2TIMSDKListener() {
            override fun onConnecting() {
                Log.d("textss", "连接成功")
            }
            override fun onConnectFailed(code: Int, error: String?) {
                Log.d("textss", "连接失败")
            }
        }
        )
        basicMessageChannel = BasicMessageChannel<Any>(flutterEngine.dartExecutor.binaryMessenger, "chat", StandardMessageCodec.INSTANCE)
    }

    public fun login(userId: String, result: MethodChannel.Result) {
        signs = GenerateTestUserSig.genTestUserSig(userId)

        if (V2TIMManager.getInstance().loginStatus == 3) {
            V2TIMManager.getInstance().login(userId, signs, object : V2TIMCallback {
                override fun onError(p0: Int, p1: String?) {
                    result.error(p0.toString(), "fail", p1)
                }

                override fun onSuccess() {
                    result.success("login,success")
                }
            })
        }

        V2TIMManager.getInstance().addSimpleMsgListener(haha)
    }
    public fun send(message: String, userId: String, result: MethodChannel.Result) {

        V2TIMManager.getInstance().sendC2CTextMessage(message, userId, object : V2TIMValueCallback<V2TIMMessage> {
            override fun onError(p0: Int, p1: String?) {
                result.success(mutableMapOf("code" to (p0), "message" to (p1)))
            }

            override fun onSuccess(p0: V2TIMMessage?) {
                result.success("send,success")
            }
        })
    }

    public fun intoRoom(result: MethodChannel.Result) {
        result.success("init room")
     }

    public fun logout(result: MethodChannel.Result?) {
        V2TIMManager.getInstance().logout(
                object : V2TIMCallback {
                    override fun onError(p0: Int, p1: String?) {
                        // Log.d("tag","logout fail")
                        result?.success(mutableMapOf("code" to (p0), "message" to (p1)))
                    }

                    override fun onSuccess() {
                        // Log.d("tag","logout success")
                        result?.success("logout success")
                    }
                }
        )
    }

    public fun destory() {
        logout(globalResult)
        V2TIMManager.getInstance().removeSimpleMsgListener(haha)
    }
}
