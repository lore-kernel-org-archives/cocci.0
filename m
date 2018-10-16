From: timur@kernel.org (Timur Tabi)
Date: Tue, 16 Oct 2018 12:14:02 -0500
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <alpine.DEB.2.20.1810161838450.3512@hadrien>
References: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
 <alpine.DEB.2.21.1810132318330.15695@hadrien>
 <CAOZdJXUJhwYkzJc6LLb_4Vm7nj_si8igx-fgs-q-PyRkOHr2Dw@mail.gmail.com>
 <20181016151052.GA26422@himanshu-Vostro-3559>
 <CAOZdJXXdbNO-S7iQgmV3nJ6q-1jjy0sJFGmJ7m2inZ3HLOOC3Q@mail.gmail.com>
 <alpine.DEB.2.20.1810161838450.3512@hadrien>
Message-ID: <CAOZdJXVDqxHBsOKK=+M_oazwO5Hc3uR7EsgACeg+2H3QwcWo4w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 10/16/18 11:39 AM, Julia Lawall wrote:
> I didn't find anything significant.  Maybe you can try disabling parmap,
> like you disabled pcre.  There seems to be a config option for that.

"./configure --disable-parmap" fixed the problem for me.  Thanks.
