#include "historymodel.h"
#include <QDebug>
#include <QPrintDialog>
#include <QPainter>
#include <QPrinter>
HistoryModel::HistoryModel(QObject *parent) :
    QAbstractListModel(parent)
{

    mDatas.append("null"); // begining of paper


}

int HistoryModel::rowCount(const QModelIndex &parent) const
{
    return mDatas.count();
}

QVariant HistoryModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();


    if ( role == Qt::DisplayRole){
        return mDatas.at(index.row());


    }

    return QVariant();
}

void HistoryModel::insert(const QString &text)
{
    qDebug()<<text;
    beginInsertRows(QModelIndex(),0,0);
    mDatas.insert(0,text);
    endInsertRows();
    emit countChanged();
}

const QString& HistoryModel::value(int row)
{
    if (row < mDatas.count())
        return mDatas.at(row);
    else return QString();
}

void HistoryModel::printDialog()
{

    QPrinter printer;
    printer.setPageSize(QPrinter::A4);
    //    printer.setOutputFormat(QPrinter::PdfFormat);
    //    printer.setOutputFileName("test.pdf");


    QPainter paint;
    if ( !paint.begin(&printer)){
        qWarning()<<"failed to open file";
        return;
    }

    int y = 0;
    int x = 0;

    foreach ( QString text , mDatas)
    {
        paint.drawText(x,y,text);
        y+=10;

    }

    paint.end();

    QPrintDialog * dialog = new QPrintDialog(&printer);
    dialog->exec();


}
