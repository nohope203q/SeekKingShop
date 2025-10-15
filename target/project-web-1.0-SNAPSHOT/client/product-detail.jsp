<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>${product.name}</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>


    </head>
    <body>

        <div class="container container-giant py-4">

            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${cpath}/">Trang chủ</a></li>
                    <li class="breadcrumb-item">Sản phẩm</li>
                    <li class="breadcrumb-item active">${product.name}</li>
                </ol>
            </nav>

            <!-- Top Section -->
            <div class="row g-4">
                <!-- LEFT - Product Images -->
                <div class="col-lg-7">
                    <div class="card card-soft p-3">
                        <img id="mainImg" class="main-img"
                             src="<c:url value='${product.image}'/>"
                             alt="${product.name}">
                    </div>
                </div>

                <!-- RIGHT - Product Info -->
                <div class="col-lg-5">
                    <div class="card card-soft p-3 sticky-right">
                        <h1 class="h4 fw-bold mb-2">${product.name}</h1>
                        <div class="mb-2 text-muted">Thương hiệu: <b>${product.brand}</b></div>

                        <div class="d-flex align-items-end gap-3 mb-2">
                            <div class="price-main">
                                <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/> ₫
                            </div>
                            <c:if test="${product.sold > 0}">
                                <div class="small text-success">Đã bán ${product.sold}</div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <span class="promo-badge"><i class="fa-solid fa-gift me-1"></i>Khuyến mãi</span>
                            <span class="ms-2 text-secondary small">Miễn phí giao nội thành</span>
                        </div>

                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <div class="border rounded p-2 bg-light">Màu: <b>${product.color}</b></div>
                            </div>
                            <div class="col-6">
                                <div class="border rounded p-2 bg-light">Kho: <b>${product.quantity}</b></div>
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <a class="btn btn-danger btn-lg" href="${cpath}/client/buy-now?pid=${product.id}">
                                <i class="fa-solid fa-cart-plus me-2"></i>MUA NGAY
                            </a>
                            <a class="btn btn-outline-primary" href="${cpath}/">Về trang chủ</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tabs -->
            <div class="card card-soft mt-4">
                <ul class="nav nav-tabs px-3 pt-3" role="tablist">
                    <li class="nav-item">
                        <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tab-spec" type="button">Thông số kỹ thuật</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-review" type="button">Đánh giá</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-desc" type="button">Mô tả chi tiết</button>
                    </li>
                </ul>

                <div class="tab-content p-3">
                    <!-- SPECIFICATIONS TAB -->
                    <div class="tab-pane fade show active" id="tab-spec">
                        <h5 class="mb-3">Thông số kỹ thuật</h5>
                        <c:if test="${product != null}">
                            <table class="table table-bordered specs-table">
                                <tbody>
                                    <tr>
                                        <th scope="row" style="width: 30%">Tên sản phẩm</th>
                                        <td>${product.name}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Thương hiệu</th>
                                        <td>${product.brand}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Màu sắc</th>
                                        <td>${product.color}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Giá bán</th>
                                        <td>
                                            <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/> ₫
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Số lượng trong kho</th>
                                        <td>${product.quantity}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${product == null}">
                            <p>❌ Không tìm thấy sản phẩm.</p>
                        </c:if>
                    </div>

                    <!-- REVIEWS TAB -->
                    <div class="tab-pane fade" id="tab-review">
                        <!-- Success/Error Messages -->
                        <c:if test="${not empty sessionScope.reviewSuccess}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fa-solid fa-check-circle me-2"></i>${sessionScope.reviewSuccess}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <c:remove var="reviewSuccess" scope="session"/>
                        </c:if>

                        <c:if test="${not empty sessionScope.reviewError}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fa-solid fa-exclamation-circle me-2"></i>${sessionScope.reviewError}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <c:remove var="reviewError" scope="session"/>
                        </c:if>

                        <!-- Rating Summary -->
                        <div class="rating-summary">
                            <div class="row align-items-center">
                                <div class="col-md-3 text-center border-end">
                                    <!-- Hiển thị số trung bình -->
                                    <div class="rating-number">
                                        <fmt:formatNumber value="${avgRating != null ? avgRating : 0}" maxFractionDigits="1"/>
                                    </div>

                                    <!-- Hiển thị sao: full stars, half star nếu có, còn lại empty -->
                                    <div class="rating-stars mb-2" aria-hidden="true">
                                        <c:set var="full" value="${avgFullStars != null ? avgFullStars : 0}" />
                                        <c:set var="hasHalf" value="${avgHasHalf}" />

                                        <!-- full stars -->
                                        <c:forEach begin="1" end="${full}" var="i">
                                            <i class="fa-solid fa-star rv-star"></i>
                                        </c:forEach>

                                        <!-- half star -->
                                        <c:if test="${hasHalf}">
                                            <i class="fa-solid fa-star-half-stroke rv-star"></i>
                                        </c:if>

                                        <!-- remaining empty stars -->
                                        <c:set var="remaining" value="${5 - full - (hasHalf ? 1 : 0)}" />
                                        <c:forEach begin="1" end="${remaining}" var="j">
                                            <i class="fa-regular fa-star text-muted"></i>
                                        </c:forEach>
                                    </div>

                                </div>
                            </div>

                            <!-- Review Filters -->
                            <div class="d-flex gap-2 mb-3 flex-wrap">
                                <button class="filter-btn active" onclick="filterReviews('all', this)">
                                    Tất cả (<c:out value="${totalReviews}" default="0"/>)
                                </button>

                                <c:forEach begin="1" end="5" var="i">
                                    <c:set var="star" value="${6 - i}" />
                                    <button class="filter-btn" onclick="filterReviews('${star}', this)">
                                        ${star} <i class="fa-solid fa-star rv-star"></i>
                                        (<c:out value="${ratingDistribution[star]}" default=""/>)
                                    </button>
                                </c:forEach>
                            </div>


                            <!-- Reviews List -->
                            <!-- Reviews List -->
                            <div id="reviewsList">
                                <c:if test="${not empty reviews}">
                                    <c:forEach var="rv" items="${reviews}">
                                        <div class="review-item" data-rating="${rv.rating}">
                                            <div class="d-flex align-items-center mb-2">
                                                <div class="review-avatar">${rv.user.name.substring(0,1)}</div>
                                                <div class="ms-2">
                                                    <div><strong>${rv.user.name}</strong></div>
                                                    <div class="text-warning small">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="fa-solid fa-star ${i <= rv.rating ? '' : 'text-muted'}"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <div class="small text-muted">
                                                        <fmt:formatDate value="${rv.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div>${rv.comment}</div>
                                        </div>
                                    </c:forEach>

                                </c:if>
                                <c:if test="${empty reviews}">
                                    <div class="text-center py-5 text-muted">
                                        Chưa có đánh giá nào cho sản phẩm này
                                    </div>
                                </c:if>
                            </div>
                            <!-- Review Form -->
                            <c:if test="${not empty sessionScope.account}">
                                <c:choose>
                                    <c:when test="${canReview && !hasReviewed}">
                                        <div class="review-form mt-4">
                                            <h5 class="mb-3"><i class="fa-solid fa-pen-to-square me-2"></i>Viết đánh giá của bạn</h5>
                                            <form action="${cpath}/review" method="post">
                                                <input type="hidden" name="productId" value="${product.id}">
                                                <div class="mb-3">
                                                    <label class="form-label fw-semibold">Đánh giá của bạn *</label>

                                                    <div class="star-rating">
                                                        <input type="radio" id="star5" name="rating" value="5" />
                                                        <label for="star5"><i class="fa-solid fa-star"></i></label>

                                                        <input type="radio" id="star4" name="rating" value="4" />
                                                        <label for="star4"><i class="fa-solid fa-star"></i></label>

                                                        <input type="radio" id="star3" name="rating" value="3" />
                                                        <label for="star3"><i class="fa-solid fa-star"></i></label>

                                                        <input type="radio" id="star2" name="rating" value="2" />
                                                        <label for="star2"><i class="fa-solid fa-star"></i></label>

                                                        <input type="radio" id="star1" name="rating" value="1" />
                                                        <label for="star1"><i class="fa-solid fa-star"></i></label>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="comment" class="form-label fw-semibold">Nhận xét của bạn</label>
                                                    <textarea class="form-control" id="comment" name="comment" rows="4" placeholder="Chia sẻ trải nghiệm của bạn..."></textarea>
                                                </div>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fa-solid fa-paper-plane me-2"></i>Gửi đánh giá
                                                </button>
                                            </form>
                                        </div>
                                    </c:when>

                                    <c:when test="${hasReviewed}">
                                        <div class="alert alert-info mt-4">
                                            <i class="fa-solid fa-check-circle me-2"></i>Bạn đã đánh giá sản phẩm này rồi. Cảm ơn bạn!
                                        </div>
                                    </c:when>

                                    <c:otherwise>
                                        <div class="alert alert-warning mt-4">
                                            <i class="fa-solid fa-shopping-bag me-2"></i>Bạn cần mua và nhận sản phẩm này trước khi có thể đánh giá
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>

                            <c:if test="${empty sessionScope.account}">
                                <div class="alert alert-info mt-4">
                                    <i class="fa-solid fa-info-circle me-2"></i>
                                    Vui lòng <a href="client/login.jsp" class="alert-link">đăng nhập</a> để viết đánh giá
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- DESCRIPTION TAB -->
                    <div class="tab-pane fade" id="tab-desc">
                        <div class="section-title mb-2">Mô tả sản phẩm</div>
                        <div>${product.description}</div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Filter reviews by rating
            function filterReviews(rating) {
                const reviewItems = document.querySelectorAll('.review-item');
                const filterBtns = document.querySelectorAll('.filter-btn');

                filterBtns.forEach(btn => btn.classList.remove('active'));
                event.target.classList.add('active');

                reviewItems.forEach(item => {
                    if (rating === 'all') {
                        item.style.display = 'block';
                    } else {
                        item.style.display = parseInt(item.dataset.rating) === rating ? 'block' : 'none';
                    }
                });
            }

            // Auto-activate review tab if URL parameter exists
            document.addEventListener("DOMContentLoaded", function () {
                const urlParams = new URLSearchParams(window.location.search);
                const activeTab = urlParams.get('tab');

                if (activeTab === 'review') {
                    const reviewTabButton = document.querySelector('[data-bs-target="#tab-review"]');
                    if (reviewTabButton) {
                        const tab = new bootstrap.Tab(reviewTabButton);
                        tab.show();

                        // Scroll to reviews section
                        setTimeout(() => {
                            document.getElementById('tab-review').scrollIntoView({behavior: 'smooth'});
                        }, 300);
                    }
                }
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>