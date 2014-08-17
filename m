From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Aug 2014 05:11:14 -0500 (CDT)
Subject: [Cocci] cocci: char* indexing style for linux
In-Reply-To: <1408222763.2683.107.camel@joe-AO725>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
Message-ID: <alpine.DEB.2.10.1408170510420.2599@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 16 Aug 2014, Joe Perches wrote:

> On Sat, 2014-08-16 at 13:06 -0700, Joe Perches wrote:
> > The suggested conversion to "sk->data + frame_size / 2[10]"
> > is not correct.
>
> Actually, that's rc14's uncompilable output.
> I started the email with 14 and upgraded before sending.
> rc21 does suggest a compilable output.
> I scanned it visually and didn't notice.
>
> rc21 suggests:
>
> (skb->data + frame_size / 2)[10]

So everything is fine now?  There was indeed an improvement with respect
to precendence of operators along the way.

julia
