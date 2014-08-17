From: joe@perches.com (Joe Perches)
Date: Sun, 17 Aug 2014 06:01:15 -0700
Subject: [Cocci] cocci: char* indexing style for linux
In-Reply-To: <alpine.DEB.2.10.1408170510420.2599@hadrien>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
Message-ID: <1408280475.17489.4.camel@joe-AO725>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 2014-08-17 at 05:11 -0500, Julia Lawall wrote:
> 
> On Sat, 16 Aug 2014, Joe Perches wrote:
> 
> > On Sat, 2014-08-16 at 13:06 -0700, Joe Perches wrote:
> > > The suggested conversion to "sk->data + frame_size / 2[10]"
> > > is not correct.
> >
> > Actually, th[at's rc14's uncompilable output.
> > I started the email with 14 and upgraded before sending.
> > rc21 does suggest a compilable output.
> > I scanned it visually and didn't notice.
> >
> > rc21 suggests:
> >
> > (skb->data + frame_size / 2)[10]
> 
> So everything is fine now?  There was indeed an improvement with respect
> to precendence of operators along the way.

It's compilable, but not the desired conversion.

I would prefer to be able to convert
	*(skb->data + frame_size / 2 + 10)
not to
	(skb->data + frame_size / 2)[10]
but to
	skb->data[frame_size / 2 + 10]

but I don't know how.
