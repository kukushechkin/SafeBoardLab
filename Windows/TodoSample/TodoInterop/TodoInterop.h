// TodoInterop.h

#pragma once

#include "todo_manager.h"

using namespace System;

namespace TodoInterop {

	public ref class TodoItem
	{
	public:
		TodoItem(int id, const char* title, const char* description, std::time_t dueDateUtc)
			: Id(id)
			, Title(gcnew System::String(title))
			, Description(gcnew System::String(description))
			, DueDateUtcRaw(static_cast<long>(dueDateUtc))
		{
		}

		int	Id;
		String^ Title;
		String^ Description;
		long DueDateUtcRaw;

		property System::DateTime^ DueDate
		{
			System::DateTime^ get()
			{
				System::DateTime^ epoch = gcnew System::DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind::Utc);
				return epoch->AddSeconds(static_cast<double>(DueDateUtcRaw));
			}

			void set(System::DateTime^ value)
			{
				System::DateTime^ epoch = gcnew DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind::Utc);
				System::TimeSpan^ timeSpan = System::DateTime::operator-(*value, *epoch);

				DueDateUtcRaw = static_cast<long>(timeSpan->TotalSeconds);
			}
		}

		System::String^ ToString() override
		{
			return System::String::Format("[Id: {0}; Title: \"{1}\"; Description: \"{2}\"; DueDate: {3}]", Id, Title, Description, DueDate);
		}

	};

	public ref class TodoManagerInterop
	{
	public:
		TodoManagerInterop()
			: m_todoManagerNative(new todo_sample::TodoManager)
		{

		}

		~TodoManagerInterop()
		{
			this->!TodoManagerInterop();
		}

		!TodoManagerInterop()
		{
			delete m_todoManagerNative;
		}

		bool Connect()
		{
			return m_todoManagerNative->Connect();
		}

		void Close()
		{
			return m_todoManagerNative->Close();
		}

		TodoItem^ CreateItem()
		{
			todo_sample::TodoItem nativeItem = m_todoManagerNative->CreateItem();
			return gcnew TodoItem(nativeItem.id, nativeItem.title, nativeItem.description, nativeItem.dueDateUtc);
		}

		array<TodoItem^>^ GetItems()
		{
			auto nativeItems = m_todoManagerNative->GetItems();
			array<TodoItem^>^ result = gcnew array<TodoItem^>(nativeItems.size());

			for (int i = 0; i < nativeItems.size(); ++i)
			{
				const auto& nativeItem = nativeItems.at(i);
				result[i] = gcnew TodoItem(nativeItem.id, nativeItem.title, nativeItem.description, nativeItem.dueDateUtc);
			}

			return result;
		}

	private:
		todo_sample::TodoManager* m_todoManagerNative;

	};
}
