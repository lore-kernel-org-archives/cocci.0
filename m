From: luca@coelho.fi (Luca Coelho)
Date: Wed, 22 Aug 2018 13:20:07 +0300
Subject: [Cocci] Finding and replacing a struct inside another struct
In-Reply-To: <74f2d0049e235c1bd02f94a83cdaf00eaf401174.camel@coelho.fi>
References: <ea981773c0caca06958f6dc5f5238954b520056b.camel@coelho.fi>
 <74f2d0049e235c1bd02f94a83cdaf00eaf401174.camel@coelho.fi>
Message-ID: <040d643bff98456efb34f1c4987a5e9e6ed0b93a.camel@coelho.fi>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2018-08-22 at 12:38 +0300, Luca Coelho wrote:
> On Wed, 2018-08-22 at 12:30 +0300, Luca Coelho wrote:
> > Hi,
> > 
> > I need some help again. :)
> > 
> > I have a struct (cfg80211_crypto_settings) that contains a new
> > element
> > that I want to substitute for a function call
> > (cfg_control_port_over_nl80211).  But this struct appears inside
> > another struct.
> > 
> > So I tried this:
> > 
> > First I try to find a struct that contains the struct I want (with
> > the
> > @parent_child@ rule):
> > 
> > @parent_child@
> > identifier child;
> > identifier parent_type;
> > @@
> > struct parent_type
> > {
> > ...
> > struct cfg80211_crypto_settings child;
> > ...
> > }

Unfortunately it seems that the parent struct doesn't really match with
this.  I guess I'll have to hardcode the parent struct as well.

--
Luca.
