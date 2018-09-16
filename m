From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 16 Sep 2018 17:07:20 +0200 (CEST)
Subject: [Cocci] Strange behavior with replacing multiple typedefs
In-Reply-To: <CAKCTf_YQgm-tgnsvfF6hV=sd+GjRU41XniWJqmoBFzwyDSr1-Q@mail.gmail.com>
References: <CAKCTf_YQgm-tgnsvfF6hV=sd+GjRU41XniWJqmoBFzwyDSr1-Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809161702451.4375@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 16 Sep 2018, Moustafa Mahmoud wrote:

> Hello all,
> I am facing this problem with typedefs, what I am trying to achieve is convering multiple typedefs into single ones.?
>
>
> typedef int x,y;
> into :
>
> typedef? int x;
> typedef int y;
>
>
> when I try to replace them inside functions, everything works as expected\
>
> My Rule :
> @rule1@
> identifier fn;
> type t;
> metavariable mm;
> @@
>
> ++ typedef t mm;
> fn(...){
> <+...
> - typedef t mm;
> ...+>
> }
>
> The C Code?
>
> typedef int;
> typedef int mr,e4;
>
> int main()
> {
> ? ? typedef int sss, ssd;
> }
>
> The Diff :
> diff =
> --- typedef.c
> +++ /tmp/cocci-output-91048-e42770-typedef.c
> @@ -3,7 +3,8 @@
> ?typedef int;
> ?typedef int mr,e4;
>
> +typedef int ssd;
> +typedef int sss;
> ?int main()
> ?{
> -? ? typedef int sss, ssd;
> ?}
> \ No newline at end of file
>
>
> However if I try to generalize it?
>
> @rule1@
> type t;
> metavariable mm;
> @@
>
> ++ typedef t mm;
> - typedef t mm;
>
>
>
> The C Code:
>
> typedef int;
> typedef int mr,e4;
>
> int main()
> {
> ? ? typedef int sss, ssd;
> }
>
> What I get is this :
>
> ?typedef int;
> -typedef int mr,e4;
> +typedef int e4;
> +typedef int mr;
> +typedef int;
>
> ?int main()
> ?{
> -? ? typedef int sss, ssd;
> +? ? typedef int ssd;
> +? ? typedef int sss;
> +? ? typedef int;
> ?}
> \ No newline at end of file
>
>
> You can notice the extra??"+? typedef int;" , why are those produced ? is there a way to achieve what? want without them ?

Wow, I'm thrilled that it worked at all :)  I knew that that would work
for eg int x,y,z;, but I didn't realize that it would work for typedefs
too.

I have the impression that it is pulling out the individual typedefs like
you asked, but then it is not actually deleting the typedef t ; part.
That is, it is not adding typedef int; it is just not removing the
original typedef after pulling out eg mr and e4.  I will see if I can fix
it.  In the short term , I don't see any workaround, unfortunately.

julia
