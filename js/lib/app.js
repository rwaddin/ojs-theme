var isRtl = document.body.classList.contains("rtl") ? true : false;

$(document).ready(function () {
  setUpIndexedIconList();
  setSidebarMenuHover();
  setStaticTitle();
  removeInlineCss(".editorial_team_block");

  $(".article-references-content").readmore({
    speed: 75,
    moreLink:
      '<a href="#" class="btn btn-xs btn-info readmore_references" ><i class="fa fa-chevron-circle-down" aria-hidden="true"></i> Read More</a>',
    lessLink:
      '<a href="#" class="btn btn-xs btn-info readmore_references"> Read Less <i class="fa fa-chevron-circle-up" aria-hidden="true" style="margin-left: 10px"></i>  </a>',
    speed: 1600,
    collapsedHeight: 300,
  });

  window.onscroll = function (ev) {
    if (window.innerHeight + window.scrollY >= document.body.offsetHeight) {
      $(".addthis-smartlayers").fadeOut();
    } else {
      $(".addthis-smartlayers").fadeIn();
    }
  };

  //fix not work on citation dropdown
  $(".dropdown-toggle").on("click", function () {
    $(this).next(".dropdown-menu").toggle();
  });

  //end fix citation dropdown bug

  // Initialize tag-it components
  //
  // The tag-it component is used during registration for the user to enter
  // their review interests. See: /templates/frontend/pages/userRegister.tpl
  if (typeof $.fn.tagit !== "undefined") {
    $(".tag-it").each(function () {
      var autocomplete_url = $(this).data("autocomplete-url");
      $(this).tagit({
        fieldName: $(this).data("field-name"),
        allowSpaces: true,
        autocomplete: {
          source: function (request, response) {
            $.ajax({
              url: autocomplete_url,
              data: {
                term: request.term,
              },
              dataType: "json",
              success: function (jsonData) {
                if (jsonData.status == true) {
                  response(jsonData.content);
                }
              },
            });
          },
        },
      });
    });

    /**
     * Determine if the user has opted to register as a reviewer
     *
     * @see: /templates/frontend/pages/userRegister.tpl
     */
    function isReviewerSelected() {
      var group = $("#reviewerOptinGroup").find("input");
      var is_checked = false;
      group.each(function () {
        if ($(this).is(":checked")) {
          is_checked = true;
          return false;
        }
      });

      return is_checked;
    }

    /**
     * Reveal the reviewer interests field on the registration form when a
     * user has opted to register as a reviewer
     *
     * @see: /templates/frontend/pages/userRegister.tpl
     */
    function reviewerInterestsToggle() {
      var is_checked = isReviewerSelected();
      if (is_checked) {
        $("#reviewerInterests").addClass("is_visible");
      } else {
        $("#reviewerInterests").removeClass("is_visible");
      }
    }

    // Update interests on page load and when the toggled is toggled
    reviewerInterestsToggle();
    $("#reviewerOptinGroup input").click(reviewerInterestsToggle);
  }

  //allow show / hide the context_privacy
  $('.context_roles input[type="checkbox"]').change(function (e) {
    $(this)
      .closest(".registrationRolesCheckbox")
      .find(".context_privacy")
      .removeClass("hidden");
  });
});

function setUpIndexedIconList() {
  var isMobile = window.matchMedia(
    "only screen and (max-width: 760px)"
  ).matches;
  let isTablet = window.matchMedia(
    "only screen and (min-width: 768px)"
  ).matches;
  //set up the indexed logo list
  /**
   * block name can be indexed_by or indexed-by or indexed_logo
   */
  var module_icon_list_bottom = $(".indexed_by");
  var module_icon_list = $("#customblock-indexed_by").length
    ? $("#customblock-indexed_by")
    : false;

  module_icon_list =
    !module_icon_list.length || !module_icon_list
      ? $("#customblock-indexed-by")
      : module_icon_list;
  module_icon_list =
    !module_icon_list.length || !module_icon_list
      ? $("#customblock-indexed_logo")
      : module_icon_list;
  module_icon_list =
    !module_icon_list.length || !module_icon_list
      ? $("#customblock-indexedBy")
      : module_icon_list;
  module_icon_list =
    !module_icon_list.length || !module_icon_list
      ? $("#customblock-indexedby")
      : module_icon_list;
  module_icon_list =
    !module_icon_list.length || !module_icon_list
      ? $("#customblock-indexed_by")
      : module_icon_list;
  module_icon_list =
    !module_icon_list.length || !module_icon_list
      ? $("#customblock-IndexedBy")
      : module_icon_list;
  module_icon_list =
    !module_icon_list.length || !module_icon_list
      ? $("#customblock-IndexedLogo")
      : module_icon_list;
  module_icon_list =
    !module_icon_list.length || !module_icon_list
      ? $("#customblock-indexedlogo")
      : module_icon_list;

  if (!module_icon_list || !module_icon_list.length) {
    console.log("indexedBy block not found");
    return;
  }

  //console.log(module_icon_list.length);

  module_icon_list.find("img").each(function (index) {
    var link = $(this).parent("a");
    var content = link.length ? link : this;
    module_icon_list_bottom.append(content);
  });

  var isThereIconList = module_icon_list_bottom.find("img");

  if (isThereIconList.length) module_icon_list_bottom.removeClass("hidden");

  autoplayEnable = isThereIconList.length > 5 ? true : false;

  slideNumber = isMobile ? 2 : 6;
  slideNumber = isTablet ? 4 : slideNumber;

  //console.log(slideNumber);

  module_icon_list_bottom.slick({
    infinite: true,
    slidesToShow: slideNumber,
    slidesToScroll: slideNumber,
    autoplay: autoplayEnable,
    autoplaySpeed: 4000,
    rtl: isRtl,
  });
}

function setSidebarMenuHover() {
  var sideBarMenu = $("#customblock-sidebar_menu").length
    ? $("#customblock-sidebar_menu")
    : false;
  sideBarMenu = sideBarMenu ? sideBarMenu : $("#customblock-sidebarMenu");
  sideBarMenu = sideBarMenu.length
    ? sideBarMenu
    : $("#customblock-SidebarMenu");
  sideBarMenu = sideBarMenu.length
    ? sideBarMenu
    : $("#customblock-sidebarmenu");
  sideBarMenu = sideBarMenu.length
    ? sideBarMenu
    : $("#customblock-sidebar-menu");

  if (!sideBarMenu) return;

  sideBarMenu.find("p").each(function (index) {
    $(this).addClass("side-menu_hover_effect");
  });
}

function setStaticTitle() {
  if (isEmpty($(".header-page-section"))) {
    var text = $(".page-static").find(".page-header h1").text();
    $(".header-page-section").text(text);
  }
}

function isEmpty(el) {
  return !$.trim(el.html());
}

function removeInlineCss(el) {
  $(el).find("*").removeAttr("style");
}

function moveJatsArticle() {
  // Only run on article page
  if (!$(".pkp_page_article").length) return;

  let jats = $("#jatsParserFullText");

  if (jats.length == 0) {
    jats = $(".ojt-jats-parser");
  }

  if (jats.length == 0) return;

  jats.detach().appendTo(".jats_result");

  $(".panel-tocs").fadeIn();

  new Sticky(".panel-tocs");

  $(".XML_generated").fadeIn();

  //https://stackoverflow.com/questions/3898130/check-if-a-user-has-scrolled-to-the-bottom
  $(window).scroll(function () {
    let scroll = parseInt($(window).scrollTop());
    let wHeight = parseInt($(window).height());
    let dHeight = parseInt($(document).height());
    let calculate = scroll + wHeight;

    let scrollH = wHeight == dHeight ? scroll : scroll + wHeight;

    if (scrollH > dHeight - 50) {
      $(".panel-tocs").fadeOut();
    } else {
      $(".panel-tocs").fadeIn();
    }
  });
}

moveJatsArticle();
