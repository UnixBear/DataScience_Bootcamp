/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QtQml module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or (at your option) the GNU General
** Public license version 3 or any later version approved by the KDE Free
** Qt Foundation. The licenses are as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL2 and LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-2.0.html and
** https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QQMLEXPRESSION_H
#define QQMLEXPRESSION_H

#include <QtQml/qqmlerror.h>
#include <QtQml/qqmlscriptstring.h>

#include <QtCore/qobject.h>
#include <QtCore/qvariant.h>

QT_BEGIN_NAMESPACE


class QString;
class QQmlRefCount;
class QQmlEngine;
class QQmlContext;
class QQmlExpressionPrivate;
class QQmlContextData;
class Q_QML_EXPORT QQmlExpression : public QObject
{
    Q_OBJECT
public:
    QQmlExpression();
    QQmlExpression(QQmlContext *, QObject *, const QString &, QObject * = Q_NULLPTR);
    explicit QQmlExpression(const QQmlScriptString &, QQmlContext * = Q_NULLPTR, QObject * = Q_NULLPTR, QObject * = Q_NULLPTR);
    virtual ~QQmlExpression();

    QQmlEngine *engine() const;
    QQmlContext *context() const;

    QString expression() const;
    void setExpression(const QString &);

    bool notifyOnValueChanged() const;
    void setNotifyOnValueChanged(bool);

    QString sourceFile() const;
    int lineNumber() const;
    int columnNumber() const;
    void setSourceLocation(const QString &fileName, int line, int column = 0);

    QObject *scopeObject() const;

    bool hasError() const;
    void clearError();
    QQmlError error() const;

    QVariant evaluate(bool *valueIsUndefined = Q_NULLPTR);

Q_SIGNALS:
    void valueChanged();

private:
    QQmlExpression(QQmlContextData *, QObject *, const QString &);

    Q_DISABLE_COPY(QQmlExpression)
    Q_DECLARE_PRIVATE(QQmlExpression)
    friend class QQmlDebugger;
    friend class QQmlContext;
};

QT_END_NAMESPACE

#endif // QQMLEXPRESSION_H

