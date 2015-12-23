//
//  UsefulStuff.cpp
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/22/15.
//  Copyright © 2015 Kaspersky Lab. All rights reserved.
//

#include "UsefulStuff.hpp"
#include <iostream>

MyUsefulObject::MyUsefulObject(const long data)
{
    m_data = data;
}

void MyUsefulObject::DoWork(const std::function<void(void)> doneCallback, const std::function<void(long)> progressCallback)
{
    while(m_data-- > 0) {
//        std::cout << m_data << std::endl;
        progressCallback(m_data);
    }
    doneCallback();
}
