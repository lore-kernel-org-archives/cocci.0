From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 6 Jan 2018 18:01:59 +0100 (CET)
Subject: [Cocci] Automatic generation of SmPL rules by a script rule
In-Reply-To: <c1e3f44c-63ca-3306-840b-77d677e7e91f@users.sourceforge.net>
References: <c1e3f44c-63ca-3306-840b-77d677e7e91f@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801061800370.2579@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 6 Jan 2018, SF Markus Elfring wrote:

> Hello,
>
> Is it possible to generate additional rules for a specific execution environment
> of the semantic patch language by an advanced script rule?
>
> Can a special rule generation be avoided from external software tools?

The simplest thing would be to just print the rule you want in a
python/ocaml script rule.  Some support was added at one point for
generating rules based on matches from other rules, but that code has not
been maintained, and I don't think it is likely to be updated in the
future.

julia
