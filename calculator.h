#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QObject>
#include "historymodel.h"

class Calculator : public QObject
{
    Q_OBJECT
    Q_PROPERTY (QString display READ display WRITE setDisplay NOTIFY displayChanged)
    Q_PROPERTY (QString memory READ memory NOTIFY memoryChanged)
    Q_PROPERTY (QString action READ action NOTIFY actionChanged)
    Q_PROPERTY (QString equation READ equation NOTIFY equationChanged)



public:
    explicit Calculator(QObject *parent = 0);
    const QString& display(){return mDisplay;}
    void setDisplay(const QString& text);
    void appendDisplay(const QString& text);
    void setEquation(const QString& equation);
    const QString& memory(){return mMemory;}
    Q_INVOKABLE void pressDigit(const QString& digit);
    const QString& action(){return mAction;}
    void setAction(const QString& action);
    const QString& equation(){return mEquation;}


public slots:
    void undo();
    void redo();

    //======= calc action
    void floatingPointPress();
    void calcPress(const QString& symbol);
    void egalPress();
    void sqrtPress();
    void pow2Press();
    void s1xPress();
    void piPress();
    void percentPress();
    void invertPress();
    void allClearPress();
    void clearPress();
    void memoryClearPress();
    void memoryRecallPress();
    void memoryAddPress();
    void memorySubtractPress();



    QString calc(const QString& sa, const QString& sb, const QString& symbol);


    //=== model
    HistoryModel * model(){return mHistoryModel;}



signals:
    void displayChanged();
    void memoryChanged();
    void actionChanged();
    void equationChanged();

private:
    QString mDisplay;
    QString mLastDisplay;
    QString mLastSymbol;
    QString mEquation;
    HistoryModel * mHistoryModel;
    bool mWaitingNewLine;
    QString mMemory;
    QString mAction;
    int mPrecision;

};

#endif // CALC_H
