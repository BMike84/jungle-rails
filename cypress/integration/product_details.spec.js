describe("Products Details", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Should click on first product", () => {
    cy.get(".products article a").first().click();
  });

  it("Should click on last product", () => {
    cy.get(".products article a").last().click();
  });
});
