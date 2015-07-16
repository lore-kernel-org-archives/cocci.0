From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Thu, 16 Jul 2015 12:07:50 -0700
Subject: [Cocci] GNU diff and git diff - difference on myers algorithm?
In-Reply-To: <CAB=NE6VGX332=CvhQM4sc27AM8ae5S1kdRnm5sMfoqkU=b=ebg@mail.gmail.com>
References: <CAB=NE6XRnKAY6t+dxT7vO_4wqngXvULh-CqezEAs2r99FkNCTg@mail.gmail.com>
 <0add7d95076f5b112af90d8566c29203@www.dscho.org>
 <CAB=NE6VGX332=CvhQM4sc27AM8ae5S1kdRnm5sMfoqkU=b=ebg@mail.gmail.com>
Message-ID: <CAB=NE6UFMv0qu8fJ1P2-pJCF0tSGKoW+uKhfwt0jV5fj2wZGSQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jun 12, 2015 at 11:52 AM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> OK wells I'm curious about more research / effort when trying to
> evaluate a diff with two seprate but adjoining preprocessor directives
> and if anyone has implemented an optimizaiton option to let the diff
> generator join them.
>
> For example, to let it infer that:
>
> --- a/test.c
> +++ b/test.c
> @@ -10,8 +10,6 @@ int main(int argc, char *argv[])
>
>  #ifdef FOO
>         a = 4;
> -#endif /* FOO */
> -#ifdef FOO
>         a = 5;
>  #endif /* FOO */
>
> is possible.

Anyone familiar if any tool exists today that would optimize this? Is
anyone working on it? Would git be a good place for such a thing? I'd
consider it as an option to optimize a diff. This for example is
extremely useful for us working with Coccinelle where we have a tool
writing code for us, while such an optimization might be useful to
Coccinelle it would seem like a rather generic feature, its just not
clear to me where to give such a tool a proper home.

 Luis
