From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Fri, 13 Jul 2018 15:51:03 +0530
Subject: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
In-Reply-To: <alpine.DEB.2.20.1807130540270.3044@hadrien>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <20180713074455.GA6859@himanshu-Vostro-3559>
 <20180713080023.GB9638@nautica>
 <20180713091412.GA11250@himanshu-Vostro-3559>
 <alpine.DEB.2.20.1807130540270.3044@hadrien>
Message-ID: <20180713102103.GA12972@himanshu-Vostro-3559>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Thanks Himanshu for the suggestions.
> 
> However, I'm not sure to follow the discussion.  The original problem was
> that Coccinelle was removing a comment that should be preserved.  I think
> that this occurs because the line just below the comment is completely
> removed.  Coccinelle considers that the comment belongs with that line and
> if the line is removed the comment won't make much sense.
> 
> In Himanshu's solution, the code is just not transformed at all, so as a
> side effect the comment stays too.  Is that what is wanted in this case?

Yes, there is no transformation with my solution which I advised to
prevent comment removal(which i thought was useful).

My rule is more narrower approach than the regular ones which used
"expression" metavariable.

Rest upto Dominique to choose whatever suits better :)

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
