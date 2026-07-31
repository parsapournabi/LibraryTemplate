#include <QCoreApplication>
#include <iostream>

#include <Module/ModuleTest.h>

inline bool constexpr isDevelopment()
{
#ifdef Module_DEVELOPMENT
    return true;
#else
    return false;
#endif
}

int main(int argc, char** argv)
{
    QCoreApplication app(argc, argv);
    // std::cout << "Example for " << "@MODULE_NAME@" << std::endl;
    PrintableModule pm;
    pm.smartPrint("Hello world this is test from Example Module");
    std::cout << "Development Mode: " <<  isDevelopment() << std::endl;
    return 0;
}
