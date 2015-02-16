From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 16 Feb 2015 07:59:04 -0800
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <alpine.DEB.2.10.1502161009420.2609@hadrien>
References: <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
 <alpine.DEB.2.02.1502151036100.2033@localhost6.localdomain6>
 <4f675e42e0b446d8829a42c5cc9a8dfd@BL2FFO11FD036.protection.gbl>
 <alpine.DEB.2.02.1502152207560.2278@localhost6.localdomain6>
 <88f4915b894e471aa3e551a6287e5d17@BY2FFO11FD031.protection.gbl>
 <alpine.DEB.2.02.1502152238270.2278@localhost6.localdomain6>
 <d20b2eea04ee429e9daa382827d052f8@BY2FFO11FD001.protection.gbl>
 <alpine.DEB.2.02.1502152254560.2278@localhost6.localdomain6>
 <fa1325f6cb734f9cb7b8dfc39054bdf8@BN1BFFO11FD021.protection.gbl>
 <alpine.DEB.2.10.1502161009420.2609@hadrien>
Message-ID: <d82f04f87e8f4f9cb3558757850561d3@BY2FFO11FD002.protection.gbl>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 2015-02-16 at 10:10AM +0100, Julia Lawall wrote:
> > With your help I did some more adjustments and my semantic patch replaces
> > all the typedefed structs correctly, with a single exception. The sources
> > contain one line like this:
> >   static const foo_t const foo_arry[] = {
> 
> Could you check if things work when the [] is not empty?

No, doesn't make a difference. It works though, when I remove the second
const (regardless of the size specifier).

	Soren
