From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 13 Feb 2017 22:08:10 +0100 (CET)
Subject: [Cocci] Bitfield info?
In-Reply-To: <682B6748-18A2-40EA-90D8-EB02B754B6C7@linaro.org>
References: <1B4D9683-DB44-4445-8873-B7D29FC44F7B@linaro.org>
 <CA+MoWDoXAEwqyhZzicB3dk4R5gghnwfXTcOmFfF3kYA9svmNug@mail.gmail.com>
 <682B6748-18A2-40EA-90D8-EB02B754B6C7@linaro.org>
Message-ID: <alpine.DEB.2.20.1702132203030.2032@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

It's not supported in the semantic patch language.

One possible hack is to do something like the following:

@initialize:ocaml@
@@

let isfield i =
    List.length (Str.split (Str.regexp ":") i) = 2

@r@
identifier foo;
field i : script:ocaml() { isfield(i) };
type T;
@@

struct foo { ... i ... };

@script:ocaml@
i << r.i;
@@

Printf.printf "%s\n" i

The ocaml code just checks that the string representing the field
declaration contains a :

This is not working right@the moment.  It seems to be related
to a problem that I was already working on today, so I will let you know
when it is functioning on github.

julia
