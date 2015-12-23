package com.kaspersky.todo;

import android.app.LoaderManager;
import android.content.AsyncTaskLoader;
import android.content.Loader;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

public class MainActivity extends AppCompatActivity implements LoaderManager.LoaderCallbacks<List<ToDoItem>> {

	private static final int ITEMS_LOADER_ID = 1;

	private final ToDoManager mToDoManager = new ToDoManager();
	private final ToDoListAdapter mAdapter = new ToDoListAdapter();
	private final Executor mWorker = Executors.newSingleThreadExecutor();
	private final Handler mMainHandler = new Handler();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
		setSupportActionBar(toolbar);

		FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
		fab.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				mWorker.execute(new Runnable() {
					@Override
					public void run() {
						try {
							mToDoManager.create();

							mMainHandler.post(new Runnable() {
								@Override
								public void run() {
									reloadItems();
								}
							});
						} catch (IOException e) {
							Toast.makeText(MainActivity.this, e.getMessage(), Toast.LENGTH_LONG).show();
						}
					}
				});
			}
		});

		RecyclerView listView = (RecyclerView) findViewById(R.id.todo_list);
		final LinearLayoutManager layoutManager = new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false);
		listView.setLayoutManager(layoutManager);
		listView.setAdapter(mAdapter);
		reloadItems();
	}

	@Override
	protected void onResume() {
		super.onResume();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.menu_main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();

		//noinspection SimplifiableIfStatement
		if (id == R.id.action_settings) {
			return true;
		}

		return super.onOptionsItemSelected(item);
	}

	@Override
	public Loader<List<ToDoItem>> onCreateLoader(int id, Bundle args) {
		return new AsyncTaskLoader<List<ToDoItem>>(getApplicationContext()) {

			@Override
			protected void onStartLoading() {
				super.onStartLoading();
				forceLoad();
			}

			@Override
			public List<ToDoItem> loadInBackground() {
				try {
					mToDoManager.connect();
					return mToDoManager.getItems();
				} catch (IOException e) {
					e.printStackTrace();
				}
				return Collections.emptyList();
			}
		};
	}

	@Override
	public void onLoadFinished(Loader<List<ToDoItem>> loader, List<ToDoItem> data) {
		mAdapter.setItems(data);
	}

	@Override
	public void onLoaderReset(Loader<List<ToDoItem>> loader) {
		mAdapter.setItems(Collections.<ToDoItem>emptyList());
	}

	private void reloadItems() {
		getLoaderManager().restartLoader(ITEMS_LOADER_ID, null, this);
	}
}
