From: mstefani@redhat.com (Michael Stefaniuc)
Date: Wed, 31 Oct 2012 13:12:10 +0100
Subject: [Cocci] rewrite C preprocessor
In-Reply-To: <CAP6exYJmah2MZkd5XSukArznvYbe3fn38Q9o5ppJDj7Z9JNd5Q@mail.gmail.com>
References: <CAP6exYJmah2MZkd5XSukArznvYbe3fn38Q9o5ppJDj7Z9JNd5Q@mail.gmail.com>
Message-ID: <5091159A.3030007@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 10/24/2012 11:59 PM, ron minnich wrote:
> Somebody asked me about a way to semantically patch
> #ifdef X
> to
> #if configured(X)
> 
> I'm not sure I can rewrite cpp bits in coccinelle, I failed on my
> first few attempts, but .. can I?
Use perl/sed/awk

bye
	michael
