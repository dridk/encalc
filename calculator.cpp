#include "calculator.h"
#include <QDebug>
#include <QRegExp>
#include <cmath>
Calculator::Calculator(QObject *parent) :
    QObject(parent)
{
    mDisplay = "0";
    mLastDisplay = "0";
    mEquation = "";
    mMemory = "";
    mWaitingNewLine = true;
    mPrecision = 20;
    mHistoryModel = new HistoryModel;


}

void Calculator::pressDigit(const QString& digit)
{
    qDebug()<<"press digit"<<digit;
    if (digit.contains(QRegExp("^[0-9]$")))
        appendDisplay(digit);

    if ( digit==".")
        floatingPointPress();

    if ( digit=="+-")
        invertPress();

    if ( digit == "s2")
        pow2Press();

    if ( digit == "=")
        egalPress();

    if ( digit == "ac")
        allClearPress();

    if ( digit == "cl")
        clearPress();

    if ( digit == "mc")
        memoryClearPress();

    if ( digit == "m+")
        memoryAddPress();

    if ( digit == "m-")
        memorySubtractPress();

    if ( digit == "mr")
        memoryRecallPress();

    if ( digit == "1x")
        s1xPress();
    if ( digit == "%")
        percentPress();

    if ( digit == "pi")
        piPress();

    if ( (digit == "×") || (digit=="+") || (digit=="-") || (digit=="÷") || (digit=="pw") )
        calcPress(digit);

    if ( digit == "st")
        sqrtPress();

}

void Calculator::appendDisplay(const QString &text)
{
    if ((mDisplay == "0") || (mDisplay.isEmpty() || mWaitingNewLine)){
        mDisplay = text;
        mWaitingNewLine = false;
    }
    else mDisplay.append(text);
    emit displayChanged();
    setAction("");
}

void Calculator::setDisplay(const QString &text)
{
    mDisplay = text;
    emit displayChanged();
    mWaitingNewLine = true;
    setAction("");

}

void Calculator::floatingPointPress()
{
    if ( mDisplay.contains("."))
        return;
    else mDisplay.append(".");
}

void Calculator::calcPress(const QString &symbol)
{

    if (!mEquation.isEmpty()){
        setEquation(equation()+mDisplay+symbol);
        setDisplay(calc(mLastDisplay,mDisplay,mLastSymbol));

    }
    else
        setEquation(mDisplay+symbol);

    mLastDisplay = mDisplay;
    mLastSymbol = symbol;
    mWaitingNewLine = true;
}
void Calculator::egalPress()
{
    if (!mEquation.isEmpty() && !mWaitingNewLine ){
        QString temp = equation()+mDisplay;
        setDisplay(calc(mLastDisplay,mDisplay,mLastSymbol));
        temp+="="+mDisplay;
        mHistoryModel->insert(temp);
        setEquation("");


    }
}
void Calculator::sqrtPress()
{
    double a = mDisplay.toDouble();
    double result = sqrt(a);
    setDisplay(QString::number(result,'g',mPrecision));
    QString temp = "sqrt("+QString::number(a,'g',mPrecision)+")="+QString::number(result,'g',mPrecision);
    mHistoryModel->insert(temp);
}
void Calculator::piPress()
{
    setDisplay(QString::number(M_PI,'g',mPrecision));

}
void Calculator::percentPress()
{
    setDisplay(QString::number(mDisplay.toDouble()/100,'g',mPrecision));


}
void Calculator::pow2Press()
{
    double a = mDisplay.toDouble();
    double result = pow(a,2);
    setDisplay(QString::number(result,'g',mPrecision));
}
void Calculator::s1xPress()
{
    double a = mDisplay.toDouble();
    double result = 1/a;
    setDisplay(QString::number(result,'g',mPrecision));
}
void Calculator::invertPress()
{
    double a = mDisplay.toDouble();
    double result = a * -1;
    setDisplay(QString::number(result,'g',mPrecision));
}
void Calculator::allClearPress()
{
    setDisplay("0");
    setEquation("");
    mLastDisplay = "";
    mLastSymbol = "";
}
void Calculator::clearPress()
{
    setDisplay("0");
}

void Calculator::memoryClearPress()
{
    mMemory = "";
    emit memoryChanged();
}
void Calculator::memoryRecallPress()
{
    if (!mMemory.isEmpty())
        setDisplay(mMemory);
}

void Calculator::memoryAddPress()
{
    mMemory = QString::number(mMemory.toDouble() + mDisplay.toDouble(),'g',mPrecision);
    emit memoryChanged();
}
void Calculator::memorySubtractPress()
{
    mMemory = QString::number(mMemory.toDouble() - mDisplay.toDouble(),'g',mPrecision);
    emit memoryChanged();
}
QString Calculator::calc(const QString &sa, const QString &sb, const QString &symbol)
{
    double result = 0;
    double a  = sa.toDouble();
    double b  = sb.toDouble();

    if ( symbol == "+")
        result = a+b;

    if ( symbol == "-")
        result = a-b;

    if ( symbol == "×")
        result = a*b;

    if ( symbol == "÷")
        result = a/b;

    if ( symbol == "pw")
        result = pow(a,b);

    return QString::number(result,'g',mPrecision);
}

void Calculator::undo()
{
    if ( mDisplay.length() <=1)
        setDisplay("0");

    else {
        mDisplay.chop(1);
        setDisplay(mDisplay);
    }
}

void Calculator::redo()
{

}

void Calculator::setAction(const QString &action)
{
    mAction = action;
    emit actionChanged();
}

void Calculator::setEquation(const QString &equation)
{
    mEquation = equation;
    emit equationChanged();
}

