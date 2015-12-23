//
//  UsefulStuff.hpp
//  SafeBoardSandbox
//
//  Created by Vladimir Kukushkin on 12/22/15.
//  Copyright © 2015 Kaspersky Lab. All rights reserved.
//

#ifndef UsefulStuff_hpp
#define UsefulStuff_hpp

#include <functional>

class MyUsefulObject
{
public:
    MyUsefulObject(const long data);
    void DoWork(const std::function<void(void)> doneCallback, const std::function<void(long)> progressCallback);
    
private:
    long m_data;
};


#endif /* UsefulStuff_hpp */
