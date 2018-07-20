From: asmadeus@codewreck.org (Dominique Martinet)
Date: Fri, 20 Jul 2018 07:57:05 +0200
Subject: [Cocci] [PATCH v3] coccinelle: suggest replacing
 strncpy+truncation by strscpy
In-Reply-To: <alpine.DEB.2.20.1807200745400.2349@hadrien>
References: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
 <1532047018-23754-1-git-send-email-asmadeus@codewreck.org>
 <alpine.DEB.2.20.1807200731240.2349@hadrien>
 <20180720054050.GA32233@nautica>
 <alpine.DEB.2.20.1807200745400.2349@hadrien>
Message-ID: <20180720055705.GA2810@nautica>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia Lawall wrote on Fri, Jul 20, 2018:
> On Fri, 20 Jul 2018, Dominique Martinet wrote:
> > I guess there is no value in the script landing first by itself, I'll
> > just remove the script path from the commit messages and resend the
> > first few this weekend.
> 
> It's not that there is no value to the script.  The problem is that I
> don't know if the script is correct - I'm not familiar with these string
> functions.  Once the script is in the kernel, it stays there beyond your
> patches, so I would prefer to know that it is correct up front, rather
> than having to remove it afterwards.

I understand, I didn't say there is no value in the script ("landing
first by itself" doesn't mean it should/can not be taken later)

I'll bump this thread again in a couple of weeks after having resent
most of the other patches

-- 
Dominique Martinet
