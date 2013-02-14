#ifndef HISTORYMODEL_H
#define HISTORYMODEL_H

#include <QAbstractListModel>
#include <QStringList>

class HistoryModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY (int count READ count NOTIFY countChanged)
public:
    explicit HistoryModel(QObject *parent = 0);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    void insert(const QString& text);
     const QString& value(int row);
     Q_INVOKABLE void printDialog();
     int count(){return rowCount();}



signals:
     void countChanged();

public slots:

private:
    QList<QString> mDatas;

};

#endif // HISTORYMODEL_H
