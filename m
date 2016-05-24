From: ohering@suse.de (Olaf Hering)
Date: Tue, 24 May 2016 15:32:36 +0200
Subject: [Cocci] github update
In-Reply-To: <20160523214931.GA11948@wotan.suse.de>
References: <alpine.DEB.2.02.1605222116490.2250@localhost6.localdomain6>
 <20160523163721.GT11948@wotan.suse.de>
 <alpine.DEB.2.02.1605232230510.2052@localhost6.localdomain6>
 <CAB=NE6UA7+tMax4nGoznvGNwuD0VabuOP71zMzs8rmQS_9Ls9Q@mail.gmail.com>
 <alpine.DEB.2.02.1605232246310.2052@localhost6.localdomain6>
 <20160523211952.GY11948@wotan.suse.de>
 <alpine.DEB.2.02.1605232334130.2052@localhost6.localdomain6>
 <CAB=NE6Xt1iy2FtOq6DCvDnidh-r9Y+9KC1AFB=PccHVg4YXB1g@mail.gmail.com>
 <alpine.DEB.2.02.1605232343420.2052@localhost6.localdomain6>
 <20160523214931.GA11948@wotan.suse.de>
Message-ID: <541922c4-84ae-cc7c-4baf-dbd7ace43961@suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 23.05.2016 23:49, Luis R. Rodriguez wrote:
> On Mon, May 23, 2016 at 11:44:10PM +0200, Julia Lawall wrote:
>> OK, thanks.  It looks like the relese notes for Coccinelle will have to
>> discourage the use of 4.03...
>
> FWIW I was on ocaml-4.02 though. I'm now upgrading my system.

There is now a pullrq to fix a bug in configure.ac, and also a new pkg 
named ocaml-parmap to replace the built-in copy. With this coccinelle 
compiles for me.

Olaf
