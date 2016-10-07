From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 7 Oct 2016 15:08:53 +0200
Subject: [Cocci] docs: Fixing "sphinxify coccinelle.txt"?
In-Reply-To: <b17b77b4-9604-59c0-7808-09463a6a83f5@users.sourceforge.net>
References: <ea62a1ea-c566-65a0-e2fd-2ee96839cf48@users.sourceforge.net>
 <alpine.DEB.2.10.1610070749420.3074@hadrien>
 <b17b77b4-9604-59c0-7808-09463a6a83f5@users.sourceforge.net>
Message-ID: <09f3f798-5b9b-df84-e864-0593ee74e0cc@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>> Information from a commit like "docs: sphinxify coccinelle.txt and add it
>>> to dev-tools" caught also my software development attention.
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/Documentation/coccinelle.txt?id=4b9033a33494ec9154d63e706e9e47f7eb3fd59e
>>>
>>> Did an other information from a comment become outdated in the script "coccicheck"
>>> because of such changes for the documentation format?
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/scripts/coccicheck?id=c802e87fbe2d4dd58982d01b3c39bc5a781223aa#n4
>>
>> How about submitting a patch to fix the problem?
> 
> Is the published commit (from 2016-08-08 / 2016-08-18) generally questionable
> as I see it by the interface "cgit" at the moment?
> 
> * Does this one contain only the deletion of the file "Documentation/coccinelle.txt"?

It seems that I got an inappropriate impression from this kind of
data display alone.


The display for the changed file name contains only the desired addition.
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/Documentation/dev-tools/coccinelle.rst?id=4b9033a33494ec9154d63e706e9e47f7eb3fd59e


> I find another data display also interesting and more promising.
> https://patchwork.kernel.org/patch/9269973/
> 
> * Should this patch about the desired file format conversion become available
>   also by the other known interfaces?

The interface "cgit v0.12" does not indicate the involved "renaming" (similarity index 56%)
so far which can be better seen in the downloadable patch file.

Regards,
Markus
