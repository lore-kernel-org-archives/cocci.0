From: iago@itu.dk (Iago Abal)
Date: Fri, 26 Jun 2015 14:50:12 +0200
Subject: [Cocci] Various minor parsing bugs
In-Reply-To: <1435201805.2992101.307114657.0D123073@webmail.messagingengine.com>
References: <1434594839.2823366.298546905.56C27EC5@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506231430140.2554@hadrien>
 <1435098813.2577840.305986601.7F5C26BA@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506240934280.2553@hadrien>
 <1435201805.2992101.307114657.0D123073@webmail.messagingengine.com>
Message-ID: <CAGbDTvr6DpQzjYktmTjBTYWGZYxNPBWtuW1qf5nFjCBzKxQ6Cw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Daniel,

On Thu, Jun 25, 2015 at 5:10 AM, Daniel Richard G. <skunk@iskunk.org> wrote:

> Just about, yes. There are idioms like
>
>     int
>     #ifdef WIN32
>     WINAPI WinMain([...])
>     #else
>     main(int argc, char *argv[])
>     #endif
>     {
>
> and others where the conditional/surrounding parts can't stand on their
> own. The wisdom of writing code in this way may be questionable, but I
> would be happy for Coccinelle to evaluate the conditional itself, and
> process only one side. (In my case, the WIN32 side is irrelevant.)
>

Try passing --undefined WIN32 to spatch, this should work for you.
Analogously, you can use --defined <SYMBOL>. This evaluates the condition
of an #ifdef or #ifndef, and may convert them into #if 1 or #if 0. For #if
0, Coccinelle has an option --if0-passing (enabled by default) that will
ignore code under #if 0. The only constraint is that the code under the #if
0 must still be lexically valid C code, because --if0-passing works after
lexing.

Using your example and passing --undefined WIN32 I get this from Coccinelle:

PARSING: foo.c
(ONCE) CPP-commenting a #if 0 or #if LINUX_VERSION or __cplusplus
passed:#ifdef WIN32
passed:WINAPI WinMain ( [ ... ] )
passed:#else
passed:#endif

-- iago
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150626/707dca5b/attachment.html>
