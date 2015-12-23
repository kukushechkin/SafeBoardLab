package com.kaspersky.todo;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ToDoListAdapter extends RecyclerView.Adapter<ToDoListAdapter.ToDoItemViewHolder> {

	private final List<ToDoItem> mItems = new ArrayList<>();

	@Override
	public ToDoItemViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
		View view = LayoutInflater.from(parent.getContext())
			.inflate(R.layout.item_layout, parent, false);
		return new ToDoItemViewHolder(view);
	}

	@Override
	public void onBindViewHolder(ToDoItemViewHolder holder, int position) {
		holder.setItem(mItems.get(position));
	}

	@Override
	public int getItemCount() {
		return mItems.size();
	}

	public void setItems(List<ToDoItem> items) {
		mItems.clear();
		mItems.addAll(items);
		notifyDataSetChanged();
	}

	public static class ToDoItemViewHolder extends RecyclerView.ViewHolder {

		private static final DateFormat DATE_FORMAT = new SimpleDateFormat();

		private final TextView mIdView;
		private final TextView mTitleView;
		private final TextView mDateView;

		private String mTitle;
		private long mDate;

		public ToDoItemViewHolder(View itemView) {
			super(itemView);
			mIdView = (TextView) itemView.findViewById(R.id.item_id);
			mTitleView = (TextView) itemView.findViewById(R.id.item_title);
			mDateView = (TextView) itemView.findViewById(R.id.item_date);
		}

		void setItem(ToDoItem item) {
			mIdView.setText(itemView.getContext().getString(R.string.item_id_format, item.getId()));
			mTitleView.setText(item.getTitle());
			mDateView.setText(DATE_FORMAT.format(new Date(item.getDueDate())));
		}
	}
}
