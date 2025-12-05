#include "Module/ModuleTest.h"


PrintableModule::PrintableModule(QObject* parent)
{

}

void PrintableModule::smartPrint(const char* message)
{
    std::cout << __FUNCTION__ << message << std::endl;
}
