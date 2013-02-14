#include "encalc.h"
#include <QDebug>
#include <QFile>
Encalc::Encalc(QObject *parent) :
    QObject(parent)
{
   // music =Phonon::createPlayer(Phonon::MusicCategory);
}

void Encalc::playAudio(const QString &filename)
{
//    QString path = "qml/Encalc/assets/sounds/"+filename;
//    music->setCurrentSource(Phonon::MediaSource(path));
 //   music->play();
}

void Encalc::printHistory()
{
    QPrintDialog * dialog = new QPrintDialog;
    dialog->exec();
    dialog->show();
}
