<?php

/* layout_page.twig */
class __TwigTemplate_632bd45db9e79de2e0eae9260f51ae6c extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = $this->env->loadTemplate("layout.twig");

        $this->blocks = array(
            'body' => array($this, 'block_body'),
            'content' => array($this, 'block_content'),
        );
    }

    protected function doGetParent(array $context)
    {
        return "layout.twig";
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        $this->parent->display($context, array_merge($this->blocks, $blocks));
    }

    // line 3
    public function block_body($context, array $blocks = array())
    {
        // line 4
        echo "    ";
        $this->env->loadTemplate("navigation.twig")->display($context);
        // line 5
        echo "
    <div class=\"container\">
        <div class=\"row\">
            <div class=\"span12\">
                ";
        // line 9
        if (isset($context["page"])) { $_page_ = $context["page"]; } else { $_page_ = null; }
        if (twig_in_filter($_page_, array(0 => "commits", 1 => "searchcommits"))) {
            // line 10
            echo "                <form class=\"form-search pull-right\" action=\"";
            if (isset($context["app"])) { $_app_ = $context["app"]; } else { $_app_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_app_, "request"), "basepath"), "html", null, true);
            echo "/";
            if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
            echo twig_escape_filter($this->env, $_repo_, "html", null, true);
            echo "/commits/";
            if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
            echo twig_escape_filter($this->env, $_branch_, "html", null, true);
            echo "/search\" method=\"POST\">
                    <input type=\"text\" name=\"query\" class=\"input-medium search-query\" placeholder=\"Search commits...\">
                </form>
                ";
        } else {
            // line 14
            echo "                <form class=\"form-search pull-right\" action=\"";
            if (isset($context["app"])) { $_app_ = $context["app"]; } else { $_app_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_app_, "request"), "basepath"), "html", null, true);
            echo "/";
            if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
            echo twig_escape_filter($this->env, $_repo_, "html", null, true);
            echo "/tree/";
            if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
            echo twig_escape_filter($this->env, $_branch_, "html", null, true);
            echo "/search\" method=\"POST\">
                    <input type=\"text\" name=\"query\" class=\"input-medium search-query\" placeholder=\"Search tree...\">
                </form>
                ";
        }
        // line 18
        echo "
                ";
        // line 19
        if (array_key_exists("branches", $context)) {
            // line 20
            echo "                    ";
            $this->env->loadTemplate("branch_menu.twig")->display($context);
            // line 21
            echo "                ";
        }
        // line 22
        echo "
                ";
        // line 23
        $this->env->loadTemplate("menu.twig")->display($context);
        // line 24
        echo "            </div>
        </div>

        ";
        // line 27
        $this->displayBlock('content', $context, $blocks);
        // line 28
        echo "
        ";
        // line 29
        $this->env->loadTemplate("footer.twig")->display($context);
        // line 30
        echo "    </div>
";
    }

    // line 27
    public function block_content($context, array $blocks = array())
    {
    }

    public function getTemplateName()
    {
        return "layout_page.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  107 => 27,  102 => 30,  100 => 29,  97 => 28,  90 => 24,  85 => 22,  82 => 21,  77 => 19,  74 => 18,  59 => 14,  41 => 9,  35 => 5,  32 => 4,  29 => 3,  253 => 15,  243 => 13,  234 => 12,  230 => 10,  227 => 9,  180 => 69,  173 => 66,  167 => 64,  163 => 62,  159 => 61,  155 => 59,  150 => 56,  136 => 53,  131 => 52,  125 => 51,  118 => 49,  111 => 47,  108 => 46,  104 => 45,  101 => 44,  95 => 27,  88 => 23,  79 => 20,  71 => 34,  68 => 33,  64 => 31,  61 => 30,  50 => 21,  47 => 20,  44 => 10,  40 => 8,  37 => 7,  31 => 5,  26 => 3,);
    }
}
