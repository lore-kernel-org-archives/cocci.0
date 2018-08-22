From: luca@coelho.fi (Luca Coelho)
Date: Wed, 22 Aug 2018 12:30:04 +0300
Subject: [Cocci] Finding and replacing a struct inside another struct
Message-ID: <ea981773c0caca06958f6dc5f5238954b520056b.camel@coelho.fi>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I need some help again. :)

I have a struct (cfg80211_crypto_settings) that contains a new element
that I want to substitute for a function call
(cfg_control_port_over_nl80211).  But this struct appears inside
another struct.

So I tried this:

First I try to find a struct that contains the struct I want (with the
@parent_child@ rule):

@parent_child@
identifier child;
identifier parent_type;
@@
struct parent_type
{
...
struct cfg80211_crypto_settings child;
...
}

And then I try to match usage of the parent struct that I found:

@@
identifier parent_child.child;
identifier parent_child.parent_type;
identifier p;
@@
struct parent_type *p;
<...
-p.child.control_over_nl80211
+cfg_control_port_over_nl80211(&p.child)
...>


But I'm getting some cryptic errors:

struct parent_type*
warning: line 715: req, previously declared as a metavariable, is used as an identifier
warning: line 732: req, previously declared as a metavariable, is used as an identifier
warning: line 740: req, previously declared as a metavariable, is used as an identifier
warning: line 912: should name_assign_type be a metavariable?
warning: line 918: params, previously declared as a metavariable, is used as an identifier
warning: line 933: params, previously declared as a metavariable, is used as an identifier
warning: line 941: should reqid be a metavariable?
line 1175: non-structure type in field ref
struct parent_type*
warning: line 715: req, previously declared as a metavariable, is used as an identifier
warning: line 732: req, previously declared as a metavariable, is used as an identifier
warning: line 740: req, previously declared as a metavariable, is used as an identifier
warning: line 912: should name_assign_type be a metavariable?
warning: line 918: params, previously declared as a metavariable, is used as an identifier
warning: line 933: params, previously declared as a metavariable, is used as an identifier
warning: line 941: should reqid be a metavariable?
line 1175: non-structure type in field ref


Does anyone know if there is a proper way to do is?

--
Cheers,
Luca.
