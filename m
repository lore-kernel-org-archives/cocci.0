From: dan.j.williams@gmail.com (Dan Williams)
Date: Thu, 17 Aug 2017 18:01:20 -0700
Subject: [Cocci] spatch / semantic patch missing some conversions?
In-Reply-To: <alpine.DEB.2.20.1708171900460.3748@hadrien>
References: <CAA9_cmee9PYMg-v+GE4r_92EWWzmRgPN8ABJA4vExfKJhSXQ=A@mail.gmail.com>
 <alpine.DEB.2.20.1708171900460.3748@hadrien>
Message-ID: <CAA9_cmdxUxAnEbswU1kU3qfbVMp7e9qkd9zXg0CcJLTVJPugsA@mail.gmail.com>
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

I tried build id-utils from source on Fedora and using the one from
Debian, both end up with a "mkid" that segfaults when running this
script. However, I'm able to make progress without the index, just a
bit slower. Mind sharing which version of id-utils is working for you?
