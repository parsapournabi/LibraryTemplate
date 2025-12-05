#include <QCoreApplication>
#include <iostream>

#include <Module/ModuleTest.h>

int main(int argc, char** argv)
{
    QCoreApplication app(argc, argv);
    // std::cout << "Example for " << "@MODULE_NAME@" << std::endl;
    PrintableModule pm;
    pm.smartPrint("Hello world this is test from Example Module");
    return 0;
}
