From: Andreas.Bach.Aaen@BEUMERGROUP.COM (Aaen, Andreas.Bach)
Date: Tue, 30 Jun 2015 06:58:32 +0000
Subject: [Cocci] Embedded Python Reference count
In-Reply-To: <alpine.DEB.2.10.1506291509260.2330@hadrien>
References: <623657CD9C4EC04888E24CFF07E08211E13DB9F9@DKAAR-EXDB02.BEUMER.com>
 <alpine.DEB.2.10.1506291509260.2330@hadrien>
Message-ID: <623657CD9C4EC04888E24CFF07E08211E13DC274@DKAAR-EXDB02.BEUMER.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia wrote:
>Do you just want to put
>... when != E3
>    when strict
>
>here?  The when strict ensures it checks everything, including things that it interprets as error exits.

How can this cope with a c-code like this?

    str = PyString_FromString(textlic);
    PyDict_SetItemString(entry, "Licenceplate", str);
    Py_DECREF(str);

    str = PyString_FromString(textday);
    PyDict_SetItemString(entry, "Day", str);
    Py_DECREF(str);

    str = PyString_FromString(textsix);
    PyDict_SetItemString(entry, "SortIndex", str);
    Py_DECREF(str);

The str pointer must have a Py_DECREF() after each call to PyDictItemString() before the str pointer is reused to point to a new object. In the above example you have three scopes of the str pointer. The compiler most probably know this.

BR
Andreas Bach Aaen
