From: eric@regit.org (Eric Leblond)
Date: Fri, 02 Aug 2013 12:33:43 +0200
Subject: [Cocci] Question on expression meaning
In-Reply-To: <alpine.DEB.2.02.1308021134400.2035@hadrien>
References: <1375435947.11948.89.camel@ice-age.regit.org>
 <alpine.DEB.2.02.1308021134400.2035@hadrien>
Message-ID: <1375439623.11948.92.camel@ice-age.regit.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Le vendredi 02 ao?t 2013 ? 11:37 +0200, Julia Lawall a ?crit :
> On Fri, 2 Aug 2013, Eric Leblond wrote:
> 
> > Hello,
> >
> > I'm trying to achieve the following:
> >
> > void DecodeIPV6(ThreadVars *tv, DecodeThreadVars *dtv, Packet *p, uint8_t *pkt, uint16_t len, PacketQueue *pq)
> > {
> > ...
> >    /* now process the Ext headers and/or the L4 Layer */
> >    switch(IPV6_GET_NH(p)) {
> >        case IPPROTO_TCP:
> >            IPV6_SET_L4PROTO (p, IPPROTO_TCP);
> > -            return DecodeTCP(tv, dtv, p, pkt + IPV6_HEADER_LEN, IPV6_GET_PLEN(p), pq);
> > +	      DecodeTCP(tv, dtv, p, pkt + IPV6_HEADER_LEN, IPV6_GET_PLEN(p), pq);
> > +            return;
> >
> > DecodeTCP being a function returning void too. In fact Solaris compiler
> > does not accept void function to return a void function.
> >
> > My first try was:
> >
> > @@
> > identifier f;
> > identifier g;
> > @@
> >
> > void f(...)
> > {
> > ...
> > - return g(...);
> > + g(...);
> > + return;
> > ...
> > }
> >
> > But this does not work because the ... can not be put on - + lines.
> >
> > I've tried the not specific semantic patch:
> >
> > @@
> > identifier f;
> > expression E;
> > @@
> >
> > void f(...)
> > {
> > ...
> > - return E;
> > + E;
> > + return;
> > ...
> > }
> >
> > But it does not work for function (it works for "return 42;"). Any idea ?
> 
> It is quite strange that it does not work for a function call.  I will 
> look into it.

Sorry for bad information. Reading your previous mail, I understood that
there was a difference as I've put the 'return 42;' at start of the
function. So it was always reached.

And thanks for the help, it works correctly now!

--
Eric

> 
> But if you want to focus on function calls, what could be best is the 
> following (not tested):
> 
> - return
>      g(...);
> + return;
> 
> That way you preserve the spacing and newlines in the function call. 
> There could be some other formatting problems in the result, though.
> 
> The other solution would be to make the argument of g be a metavariable 
> declared as:
> 
> expression list es;
> 
> Then you can remove it and add it back.  But you will probably lose any 
> newlines within es.
> 
> julia

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 190 bytes
Desc: This is a digitally signed message part
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130802/1ce2d929/attachment.asc>
