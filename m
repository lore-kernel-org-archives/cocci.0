From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Mon, 19 Jan 2015 11:32:50 +0100
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <20150119092140.GE1907@pl-59055.rocqadm.inria.fr>
References: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
 <alpine.DEB.2.10.1501172308080.2777@hadrien>
 <A2929B64-B34C-4910-8486-16F7E2D2573C@gmail.com>
 <20150119092140.GE1907@pl-59055.rocqadm.inria.fr>
Message-ID: <71E56961-AF04-469A-8B8D-A3F9BB77C261@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Sure. 
- I?m on OSX 10.10.1.
- Following packages were installed through macports:
  * ocaml @4.02.1_0
  * ocaml-camlp4 @4.02.0.1_1
  * ocaml-findlib @1.5.5_0
  * ocaml-menhir @20141215_0
  * ocaml-pcre @7.0.4_0
- Then, I git-cloned project sources (HEAD at c5ff9af).
- Then, I run ./configure. Seems to run fine. Log attached.
- Then, I run make. Gives the mentioned error. Log attached.

Hope that helps.
Thanks!



> On 19 Jan 2015, at 10:21, S?bastien Hinderer <Sebastien.Hinderer@inria.fr> wrote:
> 
> Dear Eliseo,
> 
> Could you please describe how you installed OCaml on your Mac and
> whether / how you installed related packages?
> 
> Also, could you please let us know which version of coccinelle you are
> trying to compile and send us the config.log file configure produces?
> 
> Many thanks in advance,
> S?bastien.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.log
Type: application/octet-stream
Size: 29423 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150119/5615bfc2/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: make.log
Type: application/octet-stream
Size: 53714 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150119/5615bfc2/attachment-0003.obj>
