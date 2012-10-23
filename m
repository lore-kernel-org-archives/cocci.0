From: a.oikonomopoulos@vu.nl (Angelos Oikonomopoulos)
Date: Wed, 24 Oct 2012 00:18:34 +0200
Subject: [Cocci] licensing concerns with cocci patches
In-Reply-To: <alpine.DEB.2.02.1210232339230.1942@localhost6.localdomain6>
References: <50870DB7.8010601@vu.nl>
 <alpine.DEB.2.02.1210232339230.1942@localhost6.localdomain6>
Message-ID: <508717BA.2040002@vu.nl>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 23/10/2012 11:42 ??, Julia Lawall wrote:
> On Tue, 23 Oct 2012, Angelos Oikonomopoulos wrote:
[...]
>> The concept that the GPL would apply to the output of spatch, just
>> because spatch itself is under the GPL is well beyond far-fetched. By
>> the same logic, it could as well apply to the results of a
>> search-and-replace in emacs :)
>
> Not quite. Because thre is no GPL on the replace. The user writes the
> replace himself. What is being discussed is semantic patches that are
> GPL'd, not the fact that Coccinelle itself is GPL'd.

Oh, I misunderstood the issue in question then, sorry for my careless 
reading.

I hope everyone agrees that patches that merely report potential issues 
are fine. In the case that a semantic patch adds significant amounts of 
original code, it does sound that the authors of the semantic patches 
might need to grant an explicit exception. I seriously doubt that the 
output of patches like andand.cocci (or any search-and-replace-style 
transformation) is copyrightable, however :)

BTW, you might also consider asking the SFLC for pro-bono advice on this 
https://www.softwarefreedom.org/about/contact/

HTH,
Aggelos
