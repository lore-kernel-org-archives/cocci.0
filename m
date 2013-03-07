From: amiddelk@gmail.com (Arie Middelkoop)
Date: Thu, 7 Mar 2013 17:27:56 +0100
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <5138B81B.2040100@users.sourceforge.net>
References: <513268ED.5070703@users.sourceforge.net>
 <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
 <51348708.1000005@users.sourceforge.net>
 <alpine.DEB.2.02.1303041334270.1984@hadrien>
 <5134C06D.4070906@users.sourceforge.net>
 <alpine.DEB.2.02.1303041645030.1984@hadrien>
 <5134C654.3050706@users.sourceforge.net>
 <CANrVCd3SaNhoMzaLFYsrkB6gX7vz9Nxb5L85be48pFNZ03Q6CA@mail.gmail.com>
 <5138B81B.2040100@users.sourceforge.net>
Message-ID: <CANrVCd3HS+i84W01R-pZv5B1jz_r9HJVjJfVh1OxN1mGMmxAuA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Does it work as it is supposed to be?

2013/3/7 SF Markus Elfring <elfring@users.sourceforge.net>:
>> There is something else than you can try, although I cannot guarantee
>> that it (still) works.
>
> I see two references to the script "fake-subst.sh" in your current build
> specification "configure.ac". Do they need any adjustments so that the
> dependency on the python programming language can also be resolved during an
> out-of-source build?
>
> Regards,
> Markus
