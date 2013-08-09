From: mstefani@redhat.com (Michael Stefaniuc)
Date: Fri, 09 Aug 2013 13:05:09 +0200
Subject: [Cocci] OK, this time I *promise* I'm stuck
In-Reply-To: <CAP6exYJwt0HpKsACRGRY0PBd-Ez7PE=NZyDsKGabRSUxpHk=Xw@mail.gmail.com>
References: <CAP6exYJwt0HpKsACRGRY0PBd-Ez7PE=NZyDsKGabRSUxpHk=Xw@mail.gmail.com>
Message-ID: <5204CCE5.8030508@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 08/01/2013 05:56 PM, ron minnich wrote:
> @@
> function f;
> identifier d;
> @@
> f(...,
> -Chan *d,
> +struct chan *d,
>  ...);

There are multiple issues with this:
- function is not a metavariable, coccinelle assumes that f is an
expression of type "function".
- f( ) is a function call not a function definition.
- coccinelle doesn't detects that "Chan" is a type.

@@
identifier f, d;
typedef Chan;
type T;
@@
 T f(...,
-Chan
+struct chan
 *d, ...);

bye
	michael
