From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Tue, 27 Oct 2015 11:25:17 +0100
Subject: [Cocci] version 1.0.3 released
In-Reply-To: <20151027101421.GA14273@redhat.com>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
Message-ID: <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Richard,

Many thanks for your report!

In coccinelle's source directory, could you please try the following:

make distclean
./autogen
./configure
...

hth,

S?bastien.
