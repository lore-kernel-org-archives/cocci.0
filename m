From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Thu, 22 Jan 2015 13:56:26 +0100
Subject: [Cocci] Matching functions with attributes
In-Reply-To: <alpine.DEB.2.10.1501221350370.4079@hadrien>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
 <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
 <alpine.DEB.2.10.1501212342170.2599@hadrien>
 <02347CD6-6A31-41A9-B4EE-58163C49368C@gmail.com>
 <54C0BBF9.3040804@users.sourceforge.net>
 <606B3094-FA8F-4BC7-BDE2-FC0974EAE640@gmail.com>
 <alpine.DEB.2.10.1501221350370.4079@hadrien>
Message-ID: <508792FB-D90F-4E07-9F3E-96553412648E@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I get nothing

Given that patch (which does not include ?home_replace? in the regex), that would be the expected result.
Note that I didn?t include the full list of functions in my last patch (not to make it more confusing than necessary), but the actual patch I?m using contains all functions, including ?home_replace?. 

In any case, I?ve just realized the problem could be not in spatch, but in how I?m parsing its output through vim?s errorformat.
So, please, forget about this by now, and sorry for the noise.
If I do isolate a real failure in spatch, I will get back to you with a complete set of patch/source to reproduce it.

Thanks.


> On 22 Jan 2015, at 12:52, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> With the following source code:
> 
> int main() {
>     p = home_replace(NULL, files[i]);
>      if (p != NULL) {
>        free(files[i]);
>        files[i] = p;
>      }
> }
> 
> and the following semanticpatch:
> 
> @@ identifier func =~ "^(vim_strsave|list_alloc)$"; identifier var;
> statement S; expression E; @@
> 
>  var = func(...);
>  ... when != var = E
> * if (var != NULL)
>    S
> 
> I get nothing.  If I remove the regular expression, then I get results
> with the above semantic patch and with the following semantic partch:
> 
> @@ identifier func =~ "^(vim_strsave|list_alloc)$"; identifier var;
> statement S; expression E; @@
> 
>  var = func(...);
>  ... when != var = E
> * if (var != NULL)    S
> 
> Probably the issue inmy case is the kind of regular expression being used.
> Are you using pcre?
> 
> julia
