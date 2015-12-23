#include <jni.h>
#include <chrono>
#include "todo_manager.h"

#define JNI_CALL(__ret, __f) extern "C" __attribute__ ((visibility("default"))) __ret JNICALL Java_com_kaspersky_todo_ToDoManager_##__f

static todo_sample::TodoManager g_todoManager;

void throwIoException(JNIEnv* env, const char* desc)
{
	if (env->ExceptionCheck())
	{
		env->ExceptionDescribe();
		env->ExceptionClear();
	}
	jclass excClass = env->FindClass("java/io/IOException");
	env->ThrowNew(excClass, desc);
}

JNI_CALL(void, nativeConnect)(JNIEnv* env, jclass caller)
{
	if (!g_todoManager.Connect())
	{
		throwIoException(env, "connect failed");
	}
}

JNI_CALL(void, nativeClose)(JNIEnv* env, jclass caller)
{
	g_todoManager.Close();
}

JNI_CALL(void, nativeCreate)(JNIEnv* env, jclass caller)
{
	g_todoManager.CreateItem();
}

JNI_CALL(jobjectArray, nativeGetItems)(JNIEnv* env, jclass caller, int maxItemsLength)
{
	jclass todoItemClass = env->FindClass("com/kaspersky/todo/ToDoItem");
	jmethodID todoItemCtor = env->GetMethodID(todoItemClass, "<init>", "(ILjava/lang/String;Ljava/lang/String;J)V");
	
	todo_sample::TodoItemsCollection items = g_todoManager.GetItems();
	std::size_t numItems = items.size();
	jobjectArray todoItems = env->NewObjectArray(numItems, todoItemClass, NULL);
	for (std::size_t i = 0; i < numItems; i++)
	{
		auto dueTimeMillis = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::from_time_t(items[i].dueDateUtc).time_since_epoch()).count();
		jobject item = env->NewObject(todoItemClass, todoItemCtor, items[i].id, env->NewStringUTF(items[i].title), env->NewStringUTF(items[i].description), dueTimeMillis);
		env->SetObjectArrayElement(todoItems, i, item);
	}
	return todoItems;
}
