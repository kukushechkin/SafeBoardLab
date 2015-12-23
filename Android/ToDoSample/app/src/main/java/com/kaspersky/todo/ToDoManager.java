package com.kaspersky.todo;

import java.io.Closeable;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class ToDoManager implements Closeable {

	static {
		System.loadLibrary("todo");
	}

	public void connect() throws IOException {
		if (!nativeConnect()) {
			throw new IOException("connect failed");
		}
	}

	public void create() throws IOException {
		nativeCreate();
	}

	public List<ToDoItem> getItems() throws IOException {
		return Arrays.asList(nativeGetItems());
	}

	@Override
	public void close() throws IOException {
		nativeClose();
	}

	private static native boolean nativeConnect() throws IOException;
	private static native void nativeCreate() throws IOException;
	private static native ToDoItem[] nativeGetItems() throws IOException;
	private static native void nativeClose() throws IOException;
}
