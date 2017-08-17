From: dan.j.williams@gmail.com (Dan Williams)
Date: Thu, 17 Aug 2017 11:10:05 -0700
Subject: [Cocci] spatch / semantic patch missing some conversions?
In-Reply-To: <alpine.DEB.2.20.1708171900460.3748@hadrien>
References: <CAA9_cmee9PYMg-v+GE4r_92EWWzmRgPN8ABJA4vExfKJhSXQ=A@mail.gmail.com>
 <alpine.DEB.2.20.1708171900460.3748@hadrien>
Message-ID: <CAA9_cmfBVz-m3DAsLXpWerxN26=_zoCxXT-JwF6jkHy8kdgMbA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Aug 17, 2017 at 10:06 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> The updated semantic patch is below.  It makes one pass to collect the
> function names and then another pass to transform the functions, whereever
> they are defined.
>
> I have attached the output I get on today's linux-next.  If you want to
> run it your self, I suggest first running
>
> ~/coccinelle/scripts/idutils_index.sh
>
> in your kernel tree and then using the following command line:
>
> spatch.opt mmap.cocci --use-idutils --no-includes --include-headers --in-place /run/shm/linux-next -j X --very-quiet
>
> where X is the number of core you have available.
>
> Let me know if there are any problems.

Wow! Thank you, this is great.
