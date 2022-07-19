describe("Add Product to Cart", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Should add product to cart and display 1 in cart", () => {
    cy.get(".products article div form .btn").first().click({ force: true });
    cy.get("nav li.nav-item").contains(" My Cart (1) ");
  });
});
