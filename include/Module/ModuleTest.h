#ifndef MODULETEST_H
#define MODULETEST_H

#include <QObject>
#include <iostream>

/*!
 * \brief The PrintableModule class
 * \note this is a test of PrintableModule qdoc
 */
class PrintableModule : public QObject
{
        Q_OBJECT
    public:
        explicit PrintableModule(QObject* parent = nullptr);
        /*!
         * \brief smartPrint
         * \details just a simple print with std library.
         * \param message
         */
        void smartPrint(const char* message);
};

#endif
