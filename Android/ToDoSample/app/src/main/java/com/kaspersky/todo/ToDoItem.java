package com.kaspersky.todo;

public class ToDoItem {

	private final int mId;
	private final String mTitle;
	private final String mDescription;
	private final long mDueDate;

	public ToDoItem(int id, String title, String description, long dueDate) {
		mId = id;
		mTitle = title;
		mDescription = description;
		mDueDate = dueDate;
	}

	public int getId() {
		return mId;
	}

	public String getTitle() {
		return mTitle;
	}

	public String getDescription() {
		return mDescription;
	}

	public long getDueDate() {
		return mDueDate;
	}
}
