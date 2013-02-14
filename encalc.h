#ifndef ENCALC_H
#define ENCALC_H

#include <QObject>
//#include <Phonon>
#include <QPrintDialog>

class Encalc : public QObject
{
    Q_OBJECT
public:
    explicit Encalc(QObject *parent = 0);

    Q_INVOKABLE void playAudio(const QString& filename);
    Q_INVOKABLE void printHistory();


signals:

public slots:
private:
  //  Phonon::MediaObject *music ;

};

#endif // ENCALC_H
