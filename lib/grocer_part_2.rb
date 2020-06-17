require_relative './part_1_solution.rb'
require "pry"

def apply_coupons(cart, coupons)
  new_hashel = {}
  cart.each {|element|
    coupons.each {|c_element|
      if c_element[:item] == element[:item] && (element[:count] >= c_element[:num])
        new_hashel = {}
        new_hashel[:item] = "#{element[:item]} W/COUPON"
        new_hashel[:price] = c_element[:cost]/c_element[:num]
        new_hashel[:clearance] = element[:clearance]
        new_hashel[:count] = (element[:count]-(element[:count] % c_element[:num]))
        cart << new_hashel
        if (element[:count] > c_element[:num])
          element[:count] = (element[:count] - new_hashel[:count])
        elsif (element[:count] = c_element[:num])
          element[:count] = 0
        end
     end
    }
  }
cart
end

def apply_clearance(cart)
  cart.each {|item|
      if item[:clearance] === true
        item[:price] = (item[:price]*(0.8)).round(2)
      end
  }
cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_applied_cart = apply_coupons(consolidated_cart, coupons)
  clearance_applied_cart = apply_clearance(coupon_applied_cart)
  cart_total = 0
  clearance_applied_cart.each {|element|
    cart_total = cart_total + element[:price]*element[:count]
  }
  if cart_total > 100
    cart_total = cart_total*0.9
  end
cart_total
end
