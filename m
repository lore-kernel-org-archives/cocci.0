From: wendy.liang@xilinx.com (Jiaying Liang)
Date: Thu, 19 May 2016 21:30:52 +0000
Subject: [Cocci] How to add a field to c structure definition
In-Reply-To: <alpine.DEB.2.02.1605192249100.2049@localhost6.localdomain6>
References: <DC2968D6352D1841BA729D8C06CC9DBB796FD9AB@XSJ-PSEXMBX01.xlnx.xilinx.com>
 <alpine.DEB.2.02.1605192249100.2049@localhost6.localdomain6>
Message-ID: <DC2968D6352D1841BA729D8C06CC9DBB796FD9CF@XSJ-PSEXMBX01.xlnx.xilinx.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thanks Julia,

It works for me.
Wendy

> -----Original Message-----
> From: Julia Lawall [mailto:julia.lawall at lip6.fr]
> Sent: Thursday, May 19, 2016 1:54 PM
> To: Jiaying Liang
> Cc: cocci at systeme.lip6.fr
> Subject: Re: [Cocci] How to add a field to c structure definition
>
>
>
> On Thu, 19 May 2016, Jiaying Liang wrote:
>
> >
> > Hello,
> >
> >
> >
> > I am looking for a way to add a field to a c structure definition.
> >
> >
> >
> > I have this:
> >
> >
> >
> > struct struct_A {
> >
> >    int a;
> >
> >    int b;
> >
> > };
> >
> >
> >
> > struct struct_B {
> >
> >   int c;
> >
> >   int d;
> >
> > };
> >
> >
> >
> > I want to change ?struct struct_A? to:
> >
> > struct struct_A {
> >
> >   int a;
> >
> >   int b;
> >
> >   struct struct_B;
> >
> > };
>
> Maybe you would like something like this:
>
> @@
> @@
>
> struct struct_A {
>   ...
> + struct struct_B sb;
> };
>
> It could be that you want to add this field not only to the structure that has the
> name struct_A, but to any structure that has a field of type struct XXX.  Then you
> could say:
>
> @@
> identifier sa,x;
> @@
>
> struct sa {
>   ...
>   struct XXX x;
>   ...
> + struct struct_B sb;
> };
>
> Or the structure name might be one that you have stored in a metavariable in
> some other rule r.  So you might have:
>
> @@
> identifier r.sa;
> @@
>
> struct sa {
>   ...
> + struct struct_B sb;
> };
>
> I hope this help.  Please feel free to write back if you have further questions.
>
> julia


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
